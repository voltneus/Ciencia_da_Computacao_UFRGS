<%-- Dashboard view for the Sentinel Financial Analysis System. This JSP acts as the frontend interface for the
    ServletMedia controller. It provides a modern, dark-themed UI to upload transaction CSV files via a drag-and-drop
    zone. It also dynamically renders the processed results (from the JTable exposed by the backend) and provides a
    pipeline to download the audited output file. @author Vítor Santana Feijó @version 1.1 --%>
    <%@ page contentType="text/html;charset=UTF-8" language="java" %>
        <%@ page import="javax.swing.JTable" %>
            <%@ page import="javax.swing.table.TableModel" %>
                <!DOCTYPE html>
                <html lang="pt-BR">

                <head>
                    <meta charset="UTF-8">
                    <meta name="viewport" content="width=device-width, initial-scale=1.0">
                    <title>Processador de Transações Financeiras</title>
                    <style>
                        /* Global variables to centralize theme colors */
                        :root {
                            --bg-color: #0f172a;
                            --surface-color: #1e293b;
                            --surface-color-hover: #334155;
                            --text-primary: #f8fafc;
                            --text-secondary: #94a3b8;
                            --accent-color: #3b82f6;
                            --accent-hover: #2563eb;
                            --success-color: #10b981;
                            --success-hover: #059669;
                            --border-color: #334155;
                            --error-color: #ef4444;
                            --shadow-color: rgba(0, 0, 0, 0.3);
                            --upload-bg: rgba(30, 41, 59, 0.5);
                            --upload-bg-hover: rgba(59, 130, 246, 0.05);
                            --th-bg: rgba(15, 23, 42, 0.6);
                            --tr-even-bg: rgba(255, 255, 255, 0.02);
                            --title-gradient: linear-gradient(135deg, #60a5fa, #a78bfa);
                        }

                        [data-theme="light"] {
                            --bg-color: #f8fafc;
                            --surface-color: #ffffff;
                            --surface-color-hover: #f1f5f9;
                            --text-primary: #0f172a;
                            --text-secondary: #475569;
                            --accent-color: #2563eb;
                            --accent-hover: #1d4ed8;
                            --success-color: #059669;
                            --success-hover: #047857;
                            --border-color: #e2e8f0;
                            --error-color: #dc2626;
                            --shadow-color: rgba(0, 0, 0, 0.05);
                            --upload-bg: rgba(241, 245, 249, 0.5);
                            --upload-bg-hover: rgba(37, 99, 235, 0.05);
                            --th-bg: #f1f5f9;
                            --tr-even-bg: rgba(0, 0, 0, 0.02);
                            --title-gradient: linear-gradient(135deg, #2563eb, #7c3aed);
                        }

                        /* General page styles: modern typography and content centering */
                        body {
                            font-family: 'Inter', -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, Helvetica, Arial, sans-serif;
                            background-color: var(--bg-color);
                            color: var(--text-primary);
                            margin: 0;
                            padding: 0;
                            display: flex;
                            flex-direction: column;
                            align-items: center;
                            min-height: 100vh;
                        }

                        .container {
                            width: 100%;
                            max-width: 1400px;
                            margin: 40px auto;
                            padding: 20px;
                            box-sizing: border-box;
                        }

                        header {
                            text-align: center;
                            margin-bottom: 40px;
                            position: relative;
                        }

                        .theme-toggle {
                            position: absolute;
                            top: 0;
                            right: 0;
                            background: var(--surface-color);
                            border: 1px solid var(--border-color);
                            border-radius: 8px;
                            cursor: pointer;
                            color: var(--text-primary);
                            padding: 8px;
                            display: flex;
                            align-items: center;
                            justify-content: center;
                            transition: background-color 0.2s;
                        }

                        .theme-toggle:hover {
                            background-color: var(--surface-color-hover);
                        }

                        h1 {
                            font-size: 2.5rem;
                            font-weight: 700;
                            margin-bottom: 10px;
                            background: var(--title-gradient);
                            -webkit-background-clip: text;
                            background-clip: text;
                            -webkit-text-fill-color: transparent;
                        }

                        p.subtitle {
                            color: var(--text-secondary);
                            font-size: 1.1rem;
                        }

                        /* "Card" element, used to highlight forms and the table */
                        .card {
                            background-color: var(--surface-color);
                            border-radius: 16px;
                            padding: 30px;
                            box-shadow: 0 10px 25px -5px var(--shadow-color), 0 8px 10px -6px var(--shadow-color);
                            border: 1px solid var(--border-color);
                            margin-bottom: 30px;
                            transition: transform 0.2s ease, box-shadow 0.2s ease;
                        }

                        .card:hover {
                            box-shadow: 0 20px 25px -5px var(--shadow-color), 0 10px 10px -5px var(--shadow-color);
                        }

                        /* Dashed area for file uploads (where Drag & Drop occurs) */
                        .upload-section {
                            display: flex;
                            flex-direction: column;
                            align-items: center;
                            justify-content: center;
                            padding: 40px 20px;
                            border: 2px dashed var(--border-color);
                            border-radius: 12px;
                            background-color: var(--upload-bg);
                            transition: border-color 0.3s ease, background-color 0.3s ease;
                        }

                        .upload-section:hover,
                        .upload-section.dragover {
                            border-color: var(--accent-color);
                            background-color: var(--upload-bg-hover);
                        }

                        .file-input-wrapper {
                            position: relative;
                            margin-bottom: 20px;
                            width: 100%;
                            display: flex;
                            justify-content: center;
                        }

                        input[type="file"] {
                            display: none;
                        }

                        .file-label {
                            display: inline-block;
                            padding: 12px 24px;
                            background-color: var(--surface-color-hover);
                            color: var(--text-primary);
                            border-radius: 8px;
                            cursor: pointer;
                            font-weight: 500;
                            transition: background-color 0.2s;
                            border: 1px solid var(--border-color);
                        }

                        .file-label:hover {
                            background-color: #475569;
                        }

                        .file-name {
                            margin-top: 10px;
                            color: var(--text-secondary);
                            font-size: 0.9rem;
                        }

                        .btn {
                            padding: 12px 28px;
                            border-radius: 8px;
                            font-weight: 600;
                            font-size: 1rem;
                            cursor: pointer;
                            transition: all 0.2s;
                            border: none;
                            display: inline-flex;
                            align-items: center;
                            justify-content: center;
                            gap: 8px;
                        }

                        .btn-primary {
                            background-color: var(--accent-color);
                            color: white;
                            box-shadow: 0 4px 6px -1px rgba(59, 130, 246, 0.4);
                        }

                        .btn-primary:hover {
                            background-color: var(--accent-hover);
                            transform: translateY(-1px);
                            box-shadow: 0 6px 8px -1px rgba(59, 130, 246, 0.5);
                        }

                        .btn-success {
                            background-color: var(--success-color);
                            color: white;
                            box-shadow: 0 4px 6px -1px rgba(16, 185, 129, 0.4);
                        }

                        .btn-success:hover {
                            background-color: var(--success-hover);
                            transform: translateY(-1px);
                            box-shadow: 0 6px 8px -1px rgba(16, 185, 129, 0.5);
                        }

                        .error-message {
                            background-color: rgba(239, 68, 68, 0.1);
                            border: 1px solid var(--error-color);
                            color: #fca5a5;
                            padding: 15px;
                            border-radius: 8px;
                            margin-bottom: 20px;
                            text-align: center;
                        }

                        /* ================= Table Styles ================= */
                        /* Responsive container to ensure the table has horizontal scrolling on small screens */
                        .table-container {
                            width: 100%;
                            overflow-x: auto;
                            border-radius: 8px;
                            border: 1px solid var(--border-color);
                            background-color: var(--surface-color);
                        }

                        table {
                            width: 100%;
                            border-collapse: collapse;
                            text-align: left;
                        }

                        th,
                        td {
                            padding: 12px 16px;
                            border-bottom: 1px solid var(--border-color);
                        }

                        th {
                            background-color: var(--th-bg);
                            color: var(--text-secondary);
                            font-weight: 600;
                            text-transform: uppercase;
                            font-size: 0.8rem;
                            letter-spacing: 0.05em;
                            white-space: nowrap;
                        }

                        tr:last-child td {
                            border-bottom: none;
                        }

                        tr:nth-child(even) {
                            background-color: var(--tr-even-bg);
                        }

                        tr:hover td {
                            background-color: var(--upload-bg-hover);
                        }

                        /* ================= Table Status Colors ================= */
                        /* Background color configurations for rows depending on their status */
                        tr.row-approved td {
                            background-color: rgba(16, 185, 129, 0.05);
                        }

                        tr.row-approved:hover td {
                            background-color: rgba(16, 185, 129, 0.15);
                        }

                        tr.row-suspect td {
                            background-color: rgba(245, 158, 11, 0.05);
                        }

                        tr.row-suspect:hover td {
                            background-color: rgba(245, 158, 11, 0.15);
                        }

                        tr.row-blocked td {
                            background-color: rgba(239, 68, 68, 0.05);
                        }

                        tr.row-blocked:hover td {
                            background-color: rgba(239, 68, 68, 0.15);
                        }

                        /* Status Badges */
                        .status-badge {
                            display: inline-block;
                            padding: 4px 12px;
                            border-radius: 9999px;
                            font-size: 0.85rem;
                            font-weight: 600;
                            text-align: center;
                        }

                        .status-approved-badge {
                            background-color: rgba(16, 185, 129, 0.1);
                            color: #10b981;
                            border: 1px solid rgba(16, 185, 129, 0.2);
                        }

                        .status-suspect-badge {
                            background-color: rgba(245, 158, 11, 0.1);
                            color: #f59e0b;
                            border: 1px solid rgba(245, 158, 11, 0.2);
                        }

                        .status-blocked-badge {
                            background-color: rgba(239, 68, 68, 0.1);
                            color: #ef4444;
                            border: 1px solid rgba(239, 68, 68, 0.2);
                        }

                        .results-header {
                            display: flex;
                            justify-content: space-between;
                            align-items: center;
                            margin-bottom: 20px;
                            flex-wrap: wrap;
                            gap: 15px;
                        }

                        .results-header h2 {
                            margin: 0;
                            font-size: 1.5rem;
                            color: var(--text-primary);
                        }

                        .loading-spinner {
                            display: none;
                            width: 20px;
                            height: 20px;
                            border: 3px solid rgba(255, 255, 255, .3);
                            border-radius: 50%;
                            border-top-color: #fff;
                            animation: spin 1s ease-in-out infinite;
                            margin-right: 8px;
                        }

                        @keyframes spin {
                            to {
                                transform: rotate(360deg);
                            }
                        }

                        @keyframes slideUp {
                            from {
                                opacity: 0;
                                transform: translateY(20px);
                            }

                            to {
                                opacity: 1;
                                transform: translateY(0);
                            }
                        }
                    </style>
                    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap"
                        rel="stylesheet">
                </head>

                <body>
                    <div class="container">
                        <header>
                            <h1>Sentinel Analysis</h1>
                            <p class="subtitle">Análise avançada de transações financeiras e detecção de riscos</p>
                            <button id="themeToggle" class="theme-toggle" title="Alternar Tema">
                                <svg id="themeIcon" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                    <!-- default icon (sun) -->
                                    <circle cx="12" cy="12" r="5"></circle>
                                    <line x1="12" y1="1" x2="12" y2="3"></line>
                                    <line x1="12" y1="21" x2="12" y2="23"></line>
                                    <line x1="4.22" y1="4.22" x2="5.64" y2="5.64"></line>
                                    <line x1="18.36" y1="18.36" x2="19.78" y2="19.78"></line>
                                    <line x1="1" y1="12" x2="3" y2="12"></line>
                                    <line x1="21" y1="12" x2="23" y2="12"></line>
                                    <line x1="4.22" y1="19.78" x2="5.64" y2="18.36"></line>
                                    <line x1="18.36" y1="5.64" x2="19.78" y2="4.22"></line>
                                </svg>
                            </button>
                        </header>

                        <%-- Displays error messages if they exist. The "error" attribute is set by the Servlet in case
                            of reading or processing failures. --%>
                            <% String errorMessage=(String) request.getAttribute("error"); if (errorMessage !=null &&
                                !errorMessage.isEmpty()) { %>
                                <div class="error-message">
                                    <strong>Erro:</strong>
                                    <%= errorMessage %>
                                </div>
                                <% } %>

                                    <%-- File Upload Form "enctype=multipart/form-data" is mandatory in HTML for sending
                                        files. Sends a hidden action "process" so the Servlet knows it's the processing
                                        stage. --%>
                                        <div class="card">
                                            <form action="processa" method="post" enctype="multipart/form-data"
                                                id="uploadForm">
                                                <input type="hidden" name="action" value="process">
                                                <div class="upload-section" id="dropZone">
                                                    <svg width="64" height="64" viewBox="0 0 24 24" fill="none"
                                                        stroke="currentColor" stroke-width="1.5" stroke-linecap="round"
                                                        stroke-linejoin="round"
                                                        style="color: var(--accent-color); margin-bottom: 16px;">
                                                        <path d="M21 15v4a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2v-4"></path>
                                                        <polyline points="17 8 12 3 7 8"></polyline>
                                                        <line x1="12" y1="3" x2="12" y2="15"></line>
                                                    </svg>

                                                    <div class="file-input-wrapper">
                                                        <label for="inputFileParameter" class="file-label">
                                                            Selecionar arquivo CSV
                                                        </label>
                                                        <input type="file" id="inputFileParameter"
                                                            name="inputFileParameter" accept=".csv" required>
                                                    </div>

                                                    <div id="fileNameDisplay" class="file-name">
                                                        Nenhum arquivo selecionado ou arraste um arquivo para cá
                                                    </div>

                                                    <button type="submit" class="btn btn-primary"
                                                        style="margin-top: 24px; display: none;" id="submitBtn">
                                                        <div class="loading-spinner" id="spinner"></div>
                                                        <svg id="submitIcon" width="20" height="20" viewBox="0 0 24 24"
                                                            fill="none" stroke="currentColor" stroke-width="2"
                                                            stroke-linecap="round" stroke-linejoin="round">
                                                            <circle cx="12" cy="12" r="10"></circle>
                                                            <polyline points="12 16 16 12 12 8"></polyline>
                                                            <line x1="8" y1="12" x2="16" y2="12"></line>
                                                        </svg>
                                                        <span id="submitText">Processar Transações</span>
                                                    </button>
                                                </div>
                                            </form>
                                        </div>

                                        <%-- Processing Results Section If the "outputTable" attribute is filled from
                                            the backend, it means the processing was successful. Here we take this Java
                                            JTable and transform it into a visual table (HTML). --%>
                                            <% JTable outputTable=(JTable) request.getAttribute("outputTable"); if
                                                (outputTable !=null) { TableModel model=outputTable.getModel(); %>
                                                <div class="card" id="results"
                                                    style="animation: slideUp 0.5s ease-out;">
                                                    <div class="results-header">
                                                        <h2>Resultados da Análise</h2>
                                                        <form action="processa" method="post" style="margin: 0;">
                                                            <input type="hidden" name="action" value="download">
                                                            <button type="submit" class="btn btn-success">
                                                                <svg width="20" height="20" viewBox="0 0 24 24"
                                                                    fill="none" stroke="currentColor" stroke-width="2"
                                                                    stroke-linecap="round" stroke-linejoin="round">
                                                                    <path d="M21 15v4a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2v-4">
                                                                    </path>
                                                                    <polyline points="7 10 12 15 17 10"></polyline>
                                                                    <line x1="12" y1="15" x2="12" y2="3"></line>
                                                                </svg>
                                                                Baixar Relatório Completo
                                                            </button>
                                                        </form>
                                                    </div>

                                                    <div class="table-container">
                                                        <table>
                                                            <thead>
                                                                <tr>
                                                                    <% for (int col=0; col < model.getColumnCount();
                                                                        col++) { %>
                                                                        <th>
                                                                            <%= model.getColumnName(col) %>
                                                                        </th>
                                                                        <% } %>
                                                                </tr>
                                                            </thead>
                                                            <tbody>
                                                                <% /* Iterating over the rows of the JTable that came
                                                                    from Java */ for (int row=0; row <
                                                                    model.getRowCount(); row++) { String rowClass="" ;
                                                                    /* First loop through the row's columns: discover
                                                                    the transaction status to set the row's background
                                                                    color */ for (int col=0; col <
                                                                    model.getColumnCount(); col++) { Object
                                                                    val=model.getValueAt(row, col); if (val !=null) {
                                                                    String s=val.toString().trim().toLowerCase(); if
                                                                    (s.equals("aprovada") || s.equals("aprovado"))
                                                                    rowClass="row-approved" ; else if
                                                                    (s.equals("suspeito") || s.equals("suspeita"))
                                                                    rowClass="row-suspect" ; else if
                                                                    (s.equals("bloqueada") || s.equals("bloqueado"))
                                                                    rowClass="row-blocked" ; } } %>
                                                                    <tr class="<%= rowClass %>">
                                                                        <% /* Second loop through the columns: now we
                                                                            will actually print each cell (<td>) to the
                                                                            screen */
                                                                            for (int col = 0; col <
                                                                                model.getColumnCount(); col++) { Object
                                                                                cellValue=model.getValueAt(row, col);
                                                                                String strValue=cellValue !=null ?
                                                                                cellValue.toString() : "" ; String
                                                                                lowerStr=strValue.trim().toLowerCase();
                                                                                boolean isStatus=false; String
                                                                                badgeClass="" ; /* Checking the status
                                                                                again to transform the cell's text into
                                                                                a colored "Badge" component */ if
                                                                                (lowerStr.equals("aprovada") ||
                                                                                lowerStr.equals("aprovado")) {
                                                                                isStatus=true;
                                                                                badgeClass="status-approved-badge" ; }
                                                                                else if (lowerStr.equals("suspeito") ||
                                                                                lowerStr.equals("suspeita")) {
                                                                                isStatus=true;
                                                                                badgeClass="status-suspect-badge" ; }
                                                                                else if (lowerStr.equals("bloqueada") ||
                                                                                lowerStr.equals("bloqueado")) {
                                                                                isStatus=true;
                                                                                badgeClass="status-blocked-badge" ; } %>
                                                                                <td>
                                                                                    <% if (isStatus) { %>
                                                                                        <span
                                                                                            class="status-badge <%= badgeClass %>">
                                                                                            <%= strValue %>
                                                                                        </span>
                                                                                        <% } else { %>
                                                                                            <%= strValue %>
                                                                                                <% } %>
                                                                                </td>
                                                                                <% } %>
                                                                    </tr>
                                                                    <% } %>
                                                            </tbody>
                                                        </table>
                                                    </div>
                                                </div>
                                                <% } %>
                    </div>

                    <!--
        Section: Frontend Logic (JavaScript)
        Handles drag and drop events for the CSV file on the screen, checks if the extension is correct (.csv),
        formats the size for display (e.g. MB, KB), and applies a "Processing" animation when clicking the Submit button.
    -->
                    <script>
                        document.addEventListener('DOMContentLoaded', () => {
                            const fileInput = document.getElementById('inputFileParameter');
                            const fileNameDisplay = document.getElementById('fileNameDisplay');
                            const submitBtn = document.getElementById('submitBtn');
                            const dropZone = document.getElementById('dropZone');
                            const uploadForm = document.getElementById('uploadForm');
                            const spinner = document.getElementById('spinner');
                            const submitIcon = document.getElementById('submitIcon');
                            const submitText = document.getElementById('submitText');

                            // Theme toggle logic
                            const themeToggle = document.getElementById('themeToggle');
                            const themeIcon = document.getElementById('themeIcon');
                            
                            const sunIcon = `<circle cx="12" cy="12" r="5"></circle><line x1="12" y1="1" x2="12" y2="3"></line><line x1="12" y1="21" x2="12" y2="23"></line><line x1="4.22" y1="4.22" x2="5.64" y2="5.64"></line><line x1="18.36" y1="18.36" x2="19.78" y2="19.78"></line><line x1="1" y1="12" x2="3" y2="12"></line><line x1="21" y1="12" x2="23" y2="12"></line><line x1="4.22" y1="19.78" x2="5.64" y2="18.36"></line><line x1="18.36" y1="5.64" x2="19.78" y2="4.22"></line>`;
                            const moonIcon = `<path d="M21 12.79A9 9 0 1 1 11.21 3 7 7 0 0 0 21 12.79z"></path>`;

                            function setTheme(theme) {
                                document.documentElement.setAttribute('data-theme', theme);
                                localStorage.setItem('theme', theme);
                                if (theme === 'light') {
                                    themeIcon.innerHTML = moonIcon;
                                } else {
                                    themeIcon.innerHTML = sunIcon;
                                }
                            }

                            const savedTheme = localStorage.getItem('theme') || 'dark';
                            setTheme(savedTheme);

                            themeToggle.addEventListener('click', () => {
                                const currentTheme = document.documentElement.getAttribute('data-theme');
                                setTheme(currentTheme === 'light' ? 'dark' : 'light');
                            });

                            // Handle file selection
                            fileInput.addEventListener('change', (e) => {
                                handleFiles(e.target.files);
                            });

                            // Handle form submission animation
                            uploadForm.addEventListener('submit', (e) => {
                                if (fileInput.files.length > 0) {
                                    spinner.style.display = 'inline-block';
                                    submitIcon.style.display = 'none';
                                    submitText.textContent = 'Processando...';
                                    submitBtn.style.opacity = '0.8';
                                    submitBtn.style.cursor = 'not-allowed';
                                }
                            });

                            // Drag and drop functionality
                            ['dragenter', 'dragover', 'dragleave', 'drop'].forEach(eventName => {
                                dropZone.addEventListener(eventName, preventDefaults, false);
                            });

                            function preventDefaults(e) {
                                e.preventDefault();
                                e.stopPropagation();
                            }

                            ['dragenter', 'dragover'].forEach(eventName => {
                                dropZone.addEventListener(eventName, () => {
                                    dropZone.classList.add('dragover');
                                }, false);
                            });

                            ['dragleave', 'drop'].forEach(eventName => {
                                dropZone.addEventListener(eventName, () => {
                                    dropZone.classList.remove('dragover');
                                }, false);
                            });

                            dropZone.addEventListener('drop', (e) => {
                                const dt = e.dataTransfer;
                                const files = dt.files;

                                if (files.length > 0) {
                                    fileInput.files = files;
                                    handleFiles(files);
                                }
                            }, false);

                            function handleFiles(files) {
                                if (files.length > 0) {
                                    const file = files[0];
                                    if (file.name.endsWith('.csv')) {
                                        fileNameDisplay.textContent = `Arquivo selecionado: \${file.name} (\${formatBytes(file.size)})`;
                                        fileNameDisplay.style.color = 'var(--text-primary)';
                                        submitBtn.style.display = 'inline-flex';
                                    } else {
                                        fileNameDisplay.textContent = 'Por favor, selecione um arquivo CSV válido.';
                                        fileNameDisplay.style.color = 'var(--error-color)';
                                        submitBtn.style.display = 'none';
                                        fileInput.value = ''; // Reset input
                                    }
                                } else {
                                    fileNameDisplay.textContent = 'Nenhum arquivo selecionado ou arraste um arquivo para cá';
                                    fileNameDisplay.style.color = 'var(--text-secondary)';
                                    submitBtn.style.display = 'none';
                                }
                            }

                            function formatBytes(bytes, decimals = 2) {
                                if (!+bytes) return '0 Bytes';
                                const k = 1024;
                                const dm = decimals < 0 ? 0 : decimals;
                                const sizes = ['Bytes', 'KB', 'MB', 'GB', 'TB', 'PB', 'EB', 'ZB', 'YB'];
                                const i = Math.floor(Math.log(bytes) / Math.log(k));
                                return `\${parseFloat((bytes / Math.pow(k, i)).toFixed(dm))} \${sizes[i]}`;
                            }
                        });
                    </script>
                </body>

                </html>