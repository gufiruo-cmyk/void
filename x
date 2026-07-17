<!DOCTYPE html>
<html lang="ru">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>-- ▄░▀▒▄ and ▁▄▂▎ ▌▄ --</title>
    <style>
        @import url('https://fonts.googleapis.com/css2?family=VT323&display=swap');

        * { margin:0; padding:0; box-sizing:border-box; }

        body {
            background: #000;
            color: #f00;
            font-family: 'VT323', monospace;
            overflow-x: hidden;
            line-height: 1.05;
        }

        .scanline {
            position: fixed;
            inset: 0;
            background: repeating-linear-gradient(transparent 0px, transparent 3px, rgba(255,0,0,0.04) 3px, rgba(255,0,0,0.04) 6px);
            pointer-events: none;
            z-index: 999;
            animation: scan 7s linear infinite;
        }
        @keyframes scan { 0% { background-position: 0 0; } 100% { background-position: 0 100%; } }

        nav {
            position: fixed;
            bottom: 12px;
            left: 50%;
            transform: translateX(-50%);
            z-index: 1000;
            background: #000;
            border: 2px solid #f00;
            padding: 6px 20px;
        }
        select {
            background: #000;
            color: #f00;
            border: 2px solid #f00;
            padding: 8px 12px;
            font-size: 1.3em;
        }

        .timer {
            position: fixed;
            top: 12px;
            left: 50%;
            transform: translateX(-50%);
            background: #000;
            border: 2px solid #f00;
            padding: 6px 18px;
            z-index: 1000;
            font-size: 1.5em;
        }

        .spiral {
            position: fixed;
            inset: 0;
            z-index: 1;
            overflow: hidden;
            pointer-events: none;
        }

        .spiral marquee {
            position: absolute;
            color: #f00;
            font-size: 1.25em;
            white-space: nowrap;
            opacity: 0.85;
        }

        pre {
            color: #f00;
            text-align: center;
            padding: 30px 10px;
            font-size: 1.1em;
            z-index: 5;
            position: relative;
        }
    </style>
</head>
<body>
    <div class="scanline"></div>
    <div class="spiral" id="spiral"></div>

    <nav>
        <select id="loc-select">
            <option value="">-- where --</option>
            <option value="#start">start</option>
            <option value="#end">end</option>
            <option value="#here">here</option>
            <option value="#there">there</option>
            <option value="#now">now</option>
            <option value="#void">void</option>
        </select>
    </nav>

    <div class="timer" id="timer">00d 00h 00m 00s</div>

    <pre>
   ▄▄▄▄▄▄▄▄▄▄▄  ▄▄▄▄▄▄▄▄▄▄▄  ▄▄▄▄▄▄▄▄▄▄▄ 
  ▐░░░░░░░░░░░▌▐░░░░░░░░░░░▌▐░░░░░░░░░░░▌
   ▀▀▀▀▀▀▀▀▀▀▀  ▀▀▀▀▀▀▀▀▀▀▀  ▀▀▀▀▀▀▀▀▀▀▀ 
    </pre>

    <div id="main-content" style="position:relative; z-index:5; text-align:center; padding:40px 20px;">
        <h2 style="color:#f00;">ТЫ УЖЕ ЗДЕСЬ.</h2>
    </div>

    <script>
        // Таймер
        function updateTimer() {
            const now = new Date();
            let target = new Date(now.getFullYear(), 8, 22);
            if (now > target) target.setFullYear(target.getFullYear() + 1);

            const diff = target - now;
            const d = Math.floor(diff / 86400000);
            const h = Math.floor((diff % 86400000) / 3600000);
            const m = Math.floor((diff % 3600000) / 60000);
            const s = Math.floor((diff % 60000) / 1000);

            document.getElementById('timer').textContent = 
                `${d}d ${h.toString().padStart(2,'0')}h ${m.toString().padStart(2,'0')}m ${s.toString().padStart(2,'0')}s`;
        }
        setInterval(updateTimer, 1000);
        updateTimer();

        // Навигация (рабочие ссылки)
        const content = document.getElementById('main-content');
        const pages = {
            "#start": "<h2>START</h2><p>Ты только начал стирать себя.</p>",
            "#end": "<h2>END</h2><p>Здесь всё заканчивается. И начинается.</p>",
            "#here": "<h2>HERE</h2><p>Ты уже внутри. Прямо сейчас.</p>",
            "#there": "<h2>THERE</h2><p>Там, где тебя уже нет.</p>",
            "#now": "<h2>NOW</h2><p>Всё происходит одновременно.</p>",
            "#void": "<h2>VOID</h2><p>The void exists as the void regardless of its service.</p>"
        };

        document.getElementById('loc-select').addEventListener('change', function() {
            const val = this.value;
            if (val && pages[val]) {
                content.innerHTML = pages[val];
                window.scrollTo({ top: 300, behavior: 'smooth' });
            }
        });

        // Бегущие строки по всему сайту
        const spiral = document.getElementById('spiral');
        const phrases = [
            "some may sail blindly in search of it unprepared.",
            "The void exists as the void regardless of its service.",
            "yet always still amounts to never and nothing shall come from it.",
            "null and void",
            "there was no way out",
            "▔▇▄█░ ▒▀█▋▒ ▀░▄ ▂▀▕▆▇▔ ▁▜ ▀▍ ▕▍▅▀▌█▋█▀░ ▆▕▒▔",
            "He started looking for the gate — there was no way out."
        ];

        for (let i = 0; i < 160; i++) {
            const m = document.createElement('marquee');
            m.textContent = phrases[i % phrases.length];
            m.style.top = `${Math.random() * 100}%`;
            m.style.left = `${Math.random() * 50}%`;
            m.style.transform = `rotate(${Math.random() * 360}deg)`;
            m.setAttribute('scrollamount', 1 + Math.random() * 5);
            m.setAttribute('direction', Math.random() > 0.5 ? 'left' : 'right');
            spiral.appendChild(m);
        }

        console.log("%c0071 you are on the path", "color:#f00; font-size:18px");
    </script>
</body>
</html>
