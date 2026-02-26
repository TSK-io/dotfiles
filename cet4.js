// ==UserScript==
// @name         cet4
// @namespace    http://tampermonkey.net/
// @version      3.2
// @description  纯净无弹窗，默认隐藏面板。使用快捷键 Alt + M 唤出或隐藏控制台。适配最新版成绩标签。
// @match        *://cjcx.neea.edu.cn/*
// @match        *://*.neea.edu.cn/cet/*
// @match        *://*.neea.cn/cet/*
// @grant        none
// ==/UserScript==

(function () {
    'use strict';

    // 1. 核心替换函数 (已优化)
    function updateScoresDisplay(listening, reading, writing) {
        const calculatedTotal = String(Number(listening) + Number(reading) + Number(writing));

        // 【核心修复】：将总分、听力、阅读、写作分开独立判断并修改。
        // 使用 querySelectorAll 确保页面上出现多少次就修改多少次，避免遗漏。
        document.querySelectorAll('[code="score"]').forEach(el => {
            if (el.innerText !== calculatedTotal) el.innerText = calculatedTotal;
        });

        document.querySelectorAll('[code="sco_lc"]').forEach(el => {
            if (el.innerText !== listening) el.innerText = listening;
        });

        document.querySelectorAll('[code="sco_rd"]').forEach(el => {
            if (el.innerText !== reading) el.innerText = reading;
        });

        document.querySelectorAll('[code="sco_wt"]').forEach(el => {
            if (el.innerText !== writing) el.innerText = writing;
        });

        // 外部页面的表格成绩修改（如果有的话）
        const out_page_score = document.getElementById('achievement-tbody');
        if (out_page_score) {
            const firstRow = out_page_score.querySelector('tr:first-child');
            if (firstRow) {
                const thirdCell = firstRow.querySelector('td:nth-child(3)');
                if (thirdCell && thirdCell.innerText !== calculatedTotal) {
                    thirdCell.innerText = calculatedTotal;
                }
            }
        }
    }

    // 2. 创建用户界面 (默认隐藏)
    function createInputInterface() {
        if (document.getElementById('my-clean-score-panel')) return;

        const inputDiv = document.createElement('div');
        inputDiv.id = 'my-clean-score-panel';

        inputDiv.style.cssText = `
            display: none;
            position: fixed; top: 20px; right: 20px;
            padding: 20px; background: white;
            border: 2px solid #4CAF50; border-radius: 8px;
            z-index: 999999; box-shadow: 0 4px 15px rgba(0,0,0,0.2);
            text-align: center; font-family: sans-serif;
        `;

        const savedScores = JSON.parse(localStorage.getItem('mySavedScores')) || { listening: 0, reading: 0, writing: 0 };

        inputDiv.innerHTML = `
            <div style="margin-bottom: 5px; font-weight: bold; color: #333; font-size: 16px;">成绩修改面板</div>
            <div style="margin-bottom: 15px; font-size: 12px; color: #888;">(按 Alt + M 可随时隐藏/唤出)</div>
            <div style="margin-bottom: 10px; display: flex; justify-content: space-between; align-items: center;">
                <label style="color:#555;">听力：</label>
                <input type="number" id="my_list_score" value="${savedScores.listening}" min="0" max="249" style="width: 70px; padding: 5px; border: 1px solid #ccc; border-radius: 4px;">
            </div>
            <div style="margin-bottom: 10px; display: flex; justify-content: space-between; align-items: center;">
                <label style="color:#555;">阅读：</label>
                <input type="number" id="my_read_score" value="${savedScores.reading}" min="0" max="249" style="width: 70px; padding: 5px; border: 1px solid #ccc; border-radius: 4px;">
            </div>
            <div style="margin-bottom: 15px; display: flex; justify-content: space-between; align-items: center;">
                <label style="color:#555;">写作：</label>
                <input type="number" id="my_writ_score" value="${savedScores.writing}" min="0" max="249" style="width: 70px; padding: 5px; border: 1px solid #ccc; border-radius: 4px;">
            </div>
            <div style="display: flex; gap: 10px; justify-content: center;">
                <button id="my_save_btn" style="width: 100%; padding: 8px 15px; background: #4CAF50; color: white; border: none; border-radius: 4px; cursor: pointer; font-weight: bold;">保存并修改</button>
            </div>
        `;
        document.body.appendChild(inputDiv);

        document.getElementById('my_save_btn').addEventListener('click', function () {
            const listening = document.getElementById('my_list_score').value || "0";
            const reading = document.getElementById('my_read_score').value || "0";
            const writing = document.getElementById('my_writ_score').value || "0";

            localStorage.setItem('mySavedScores', JSON.stringify({ listening, reading, writing }));
            updateScoresDisplay(listening, reading, writing);

            const btn = this;
            btn.innerText = "已保存!";
            btn.style.background = "#45a049";
            setTimeout(() => { btn.innerText = "保存并修改"; btn.style.background = "#4CAF50"; }, 1500);
        });
    }

    // 添加全局键盘监听器
    function setupKeyboardShortcut() {
        document.addEventListener('keydown', function(event) {
            if (event.altKey && event.key.toLowerCase() === 'm') {
                const panel = document.getElementById('my-clean-score-panel');
                if (panel) {
                    panel.style.display = panel.style.display === 'none' ? 'block' : 'none';
                }
            }
        });
    }

    // 3. 页面加载与智能监听逻辑
    function init() {
        createInputInterface();
        setupKeyboardShortcut();

        const savedScores = JSON.parse(localStorage.getItem('mySavedScores'));
        if (savedScores) {
            updateScoresDisplay(savedScores.listening, savedScores.reading, savedScores.writing);
        }

        const observer = new MutationObserver((mutations) => {
            const currentScores = JSON.parse(localStorage.getItem('mySavedScores'));
            if (currentScores && document.querySelector('[code="score"]')) {
                 updateScoresDisplay(currentScores.listening, currentScores.reading, currentScores.writing);
            }
        });

        observer.observe(document.body, { childList: true, subtree: true, characterData: true });
    }

    if (document.readyState === 'loading') {
        document.addEventListener('DOMContentLoaded', init);
    } else {
        init();
    }

})();
