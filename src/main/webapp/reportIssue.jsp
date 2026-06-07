<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=yes">
    <title>CivicSpark - Report Issue Module | Multi-Image Upload (Up to 5)</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        /* Import modern font */
        @import url('https://fonts.googleapis.com/css2?family=Inter:opsz,wght@14..32,300;14..32,400;14..32,500;14..32,600;14..32,700&display=swap');

        /* Color palette: Terracotta, Cream, Teal */
        :root {
            --terracotta: #16a34a;
            --terracotta-dark: #09662b;
            --terracotta-light: #D4894E;
            --cream: #F6F9F7;
            --cream-light: white;
            --cream-dark: #E8D5BC;
            --teal: #008080;
            --teal-dark: #004C4C;
            --teal-light: #20B2AA;
            --text-primary: #5C3A21;
            --text-secondary: #004C4C;
            --text-muted: #8B7355;
            --border: #D4C5B0;
            --shadow-sm: 0 4px 12px rgba(92, 58, 33, 0.08);
            --shadow-md: 0 8px 24px rgba(92, 58, 33, 0.12);
            --error: #D9534F;
            --success: #2E8B57;
        }

        body {
            background: var(--cream);
            font-family: 'Inter', system-ui, -apple-system, 'Segoe UI', sans-serif;
            padding: 2rem;
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
        }

        /* Two-column layout */
        .report-container {
            max-width: 1280px;
            width: 100%;
            margin: 0 auto;
        }

        .two-columns {
            display: grid;
            grid-template-columns: 1fr 1.1fr;
            gap: 2rem;
        }

        /* LEFT CARD: Attach Photos (Drag & Drop + Multi Preview Grid) */
        .upload-card {
            background: white;
            border-radius: 10px;
            padding: 1.8rem;
            box-shadow: var(--shadow-sm);
            transition: transform 0.2s ease, box-shadow 0.2s ease;
            height: fit-content;
        }

        .upload-card:hover {
            box-shadow: var(--shadow-md);
        }

        .section-title {
            font-size: 1.3rem;
            font-weight: 700;
            color: var(--teal-dark);
            margin-bottom: 1.5rem;
            display: flex;
            align-items: center;
            gap: 10px;
            border-left: 5px solid var(--terracotta);
            padding-left: 16px;
        }

        .drop-zone {
            border: 2px dashed var(--terracotta);
            border-radius: 10px;
            background: var(--cream-light);
            padding: 2rem 1rem;
            text-align: center;
            cursor: pointer;
            transition: all 0.25s ease;
            margin-bottom: 1.5rem;
        }

        .drop-zone.dragover {
            border-color: var(--teal);
            background: var(--cream-dark);
            transform: scale(0.98);
        }

        .drop-icon {
            font-size: 52px;
            margin-bottom: 12px;
        }

        .drop-text {
            font-weight: 600;
            font-size: 1rem;
            color: var(--text-primary);
            margin-bottom: 6px;
        }

        .drop-hint {
            font-size: 0.75rem;
            color: var(--text-muted);
        }

        .counter-info {
            font-size: 0.75rem;
            font-weight: 500;
            background: var(--cream-dark);
            display: inline-block;
            padding: 4px 12px;
            border-radius: 40px;
            margin-bottom: 12px;
            color: var(--teal-dark);
        }

        .file-input-hidden {
            display: none;
        }

        /* Multi image preview grid */
        .preview-grid-area {
            background: var(--cream-light);
            border-radius: 10px;
            padding: 1.2rem;
            margin-top: 0.5rem;
            border: 1px solid var(--border);
        }

        .preview-label {
            font-size: 0.85rem;
            font-weight: 600;
            color: var(--text-secondary);
            margin-bottom: 14px;
            letter-spacing: 0.3px;
            display: flex;
            justify-content: space-between;
            align-items: baseline;
            flex-wrap: wrap;
            gap: 8px;
        }

        .image-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(90px, 100px));
            gap: 14px;
            margin-bottom: 16px;
        }

        .image-preview-card {
            position: relative;
            border-radius: 10px;
            overflow: hidden;
            background: #f3f0ea;
            aspect-ratio: 1 / 1;
            box-shadow: var(--shadow-sm);
            border: 1px solid var(--border);
            transition: transform 0.2s;
        }

        .image-preview-card:hover {
            transform: scale(1.02);
        }

        .preview-img-thumb {
            width: 100%;
            height: 100%;
            object-fit: cover;
            display: block;
        }

        .remove-single-btn {
            position: absolute;
            top: 6px;
            right: 6px;
            background: rgba(0,0,0,0.7);
            backdrop-filter: blur(2px);
            color: white;
            border: none;
            border-radius: 30px;
            width: 26px;
            height: 26px;
            font-size: 14px;
            font-weight: bold;
            cursor: pointer;
            display: flex;
            align-items: center;
            justify-content: center;
            transition: all 0.2s;
        }

        .remove-single-btn:hover {
            background: var(--error);
            transform: scale(1.05);
        }

        .add-more-hint {
            font-size: 0.7rem;
            color: var(--teal);
            margin-top: 8px;
            text-align: center;
            background: var(--cream);
            padding: 6px;
            border-radius: 30px;
        }

        .warning-limit {
            color: var(--error);
            font-size: 0.7rem;
            font-weight: 500;
        }

        /* RIGHT CARD: Form */
        .form-card {
            background: var(--cream-light);
            border-radius: 10px;
            padding: 1.8rem;
            box-shadow: var(--shadow-sm);
            transition: box-shadow 0.2s ease;
        }

        .form-card:hover {
            box-shadow: var(--shadow-md);
        }

        .form-group {
            margin-bottom: 1.4rem;
        }

        label {
            font-weight: 600;
            color: var(--text-secondary);
            display: block;
            margin-bottom: 8px;
            font-size: 0.85rem;
            letter-spacing: 0.3px;
        }

        input, select, textarea {
            width: 100%;
            padding: 12px 16px;
            border: 1.5px solid var(--border);
            border-radius: 10px;
            background: var(--cream-light);
            font-family: 'Inter', sans-serif;
            font-size: 0.9rem;
            color: var(--text-primary);
            transition: all 0.2s;
        }

        input:focus, select:focus, textarea:focus {
            outline: none;
            border-color: var(--teal);
            box-shadow: 0 0 10px rgba(23, 92, 252, 0.408);
        }

        textarea {
            resize: vertical;
            min-height: 100px;
        }

        .btns{
            display: flex;
            gap: 20px;
        }

        .submit-btn {
            background: var(--terracotta);
            color: var(--cream-light);
            border: none;
            padding: 10px;
            border-radius: 10px;
            font-weight: 700;
            font-size: 1rem;
            cursor: pointer;
            transition: all 0.25s ease;
            margin-top: 10px;
            font-family: 'Inter', sans-serif;
            letter-spacing: 0.5px;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 8px;
        }

        .submit-btn:hover {
            background: var(--terracotta-dark);
            transform: translateY(-2px);
            box-shadow: var(--shadow-sm);
        }

        .submit-btn:active {
            transform: translateY(1px);
        }
        
        .submit-btn:disabled {
            background: #cccccc;
            cursor: not-allowed;
            transform: none;
        }

        .back-btn {
            background: var(--terracotta);
            color: var(--cream-light);
            border: none;
            padding: 10px 30px;
            border-radius: 10px;
            font-weight: 700;
            font-size: 1rem;
            cursor: pointer;
            transition: all 0.25s ease;
            margin-top: 10px;
            font-family: 'Inter', sans-serif;
            letter-spacing: 0.5px;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 8px;
        }

        .back-btn:hover {
            background: var(--terracotta-dark);
            transform: translateY(-2px);
            box-shadow: var(--shadow-sm);
        }

        .back-btn:active {
            transform: translateY(1px);
        }

        /* Toast notification style */
        .toast-notification {
            position: fixed;
            bottom: 20px;
            right: 20px;
            background: white;
            border-radius: 10px;
            padding: 15px 20px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.15);
            z-index: 1000;
            animation: slideIn 0.3s ease;
            border-left: 4px solid var(--success);
        }
        
        .toast-notification.error {
            border-left-color: var(--error);
        }
        
        @keyframes slideIn {
            from {
                transform: translateX(100%);
                opacity: 0;
            }
            to {
                transform: translateX(0);
                opacity: 1;
            }
        }

        @media (max-width: 850px) {
            body {
                padding: 1rem;
            }
            .two-columns {
                grid-template-columns: 1fr;
                gap: 1.5rem;
            }
            .image-grid {
                grid-template-columns: repeat(auto-fill, minmax(75px, 80px));
            }
        }

        .required-star {
            color: var(--terracotta);
            margin-left: 3px;
        }

        .char-hint {
            font-size: 0.7rem;
            color: var(--text-muted);
            text-align: right;
            margin-top: 4px;
        }
    </style>
</head>
<body>
<div class="report-container">
    <div class="two-columns">
        <!-- LEFT COLUMN: Multi-Image Upload (Drag & Drop + Gallery Grid) -->
        <div class="upload-card">
            <div class="section-title">
                📸 Attach Photos <span style="font-size: 0.85rem; font-weight: normal;">(Up to 5 images)</span>
            </div>
            <!-- Drag & Drop Zone -->
            <div id="dropZone" class="drop-zone">
                <div class="drop-icon">🖼️📷</div>
                <div class="drop-text">Drag & drop images here<br>or <strong style="color: var(--terracotta);">click to browse</strong></div>
                <div class="drop-hint">JPG, PNG, GIF up to 5 MB each | Max 5 images</div>
            </div>
            <input type="file" id="fileInput" accept="image/*" multiple class="file-input-hidden">
            
            <!-- Multi Preview Grid Section -->
            <div id="previewGridContainer" class="preview-grid-area" style="display: none;">
                <div class="preview-label">
                    <span>📷 Selected Images (<span id="imageCountDisplay">0</span>/5)</span>
                    <button type="button" id="clearAllImagesBtn" style="background: none; border: none; color: var(--error); font-size: 0.7rem; cursor: pointer; font-weight: 600;">🗑️ Clear all</button>
                </div>
                <div id="imageGrid" class="image-grid">
                    <!-- dynamic preview cards will appear here -->
                </div>
                <div id="addMoreHint" class="add-more-hint">✨ You can add up to 5 photos. Drag more or click zone to add.</div>
            </div>
        </div>

        <!-- RIGHT COLUMN: Report New Issue Form -->
        <div class="form-card">
            <div class="section-title">
                📋 Report New Issue
            </div>
            <form id="issueForm" method="post" enctype="multipart/form-data">
                <div class="form-group">
                    <label>Issue Title <span class="required-star">*</span></label>
                    <input type="text" id="issueTitle" name="title" placeholder="e.g., Broken drainage near school" maxlength="120">
                    <div class="char-hint">max 120 characters</div>
                </div>
                
                <div class="form-group">
                    <label>Category <span class="required-star">*</span></label>
                    <select id="categorySelect" name="category">
                        <option value="">-- Select Category --</option>
                        <!-- Categories will be loaded dynamically from database -->
                    </select>
                </div>
                
                <div class="form-group">
                    <label>Description <span class="required-star">*</span></label>
                    <textarea id="issueDesc" name="description" placeholder="Describe the problem in detail..."></textarea>
                </div>
                
                <div class="form-group">
                    <label>Location / Address <span class="required-star">*</span></label>
                    <input type="text" id="issueLocation" name="location" placeholder="Village name, street, landmark">
                </div>
                
                <div class="btns">
                    <button type="button" id="backBtn" class="back-btn">
                        Back
                    </button>
                    <button type="button" id="submitReportBtn" class="submit-btn">
                        Submit Report
                    </button>
                </div>
            </form>
        </div>
    </div>
</div>

<script>
    // ==================== MULTI IMAGE UPLOAD LOGIC (MAX 5) ====================
    const dropZone = document.getElementById('dropZone');
    const fileInput = document.getElementById('fileInput');
    const previewGridContainer = document.getElementById('previewGridContainer');
    const imageGrid = document.getElementById('imageGrid');
    const imageCountDisplay = document.getElementById('imageCountDisplay');
    const clearAllBtn = document.getElementById('clearAllImagesBtn');
    const addMoreHint = document.getElementById('addMoreHint');
    
    let selectedFiles = [];  // stores File objects (max 5)

    // Helper: update UI (grid, counters, visibility)
    function updateGalleryUI() {
        const count = selectedFiles.length;
        imageCountDisplay.innerText = count;
        
        if (count === 0) {
            previewGridContainer.style.display = 'none';
            fileInput.value = '';  // clear native input
            return;
        }
        
        previewGridContainer.style.display = 'block';
        
        // rebuild grid
        imageGrid.innerHTML = '';
        selectedFiles.forEach((file, idx) => {
            const card = document.createElement('div');
            card.className = 'image-preview-card';
            const img = document.createElement('img');
            img.className = 'preview-img-thumb';
            // create object URL for preview
            const url = URL.createObjectURL(file);
            img.src = url;
            img.onload = () => URL.revokeObjectURL(url); // cleanup after load
            const removeBtn = document.createElement('button');
            removeBtn.className = 'remove-single-btn';
            removeBtn.innerHTML = '✕';
            removeBtn.title = 'Remove this image';
            removeBtn.addEventListener('click', (e) => {
                e.stopPropagation();
                removeImageAtIndex(idx);
            });
            card.appendChild(img);
            card.appendChild(removeBtn);
            imageGrid.appendChild(card);
        });
        
        // update hint & warning
        if (count >= 5) {
            addMoreHint.innerHTML = '⚠️ Maximum 5 images reached. Remove some before adding more.';
            addMoreHint.style.color = 'var(--error)';
            addMoreHint.style.fontWeight = '500';
        } else {
            addMoreHint.innerHTML = '📸 You can add up to 5 photos. Drag more or click zone to add.';
            addMoreHint.style.color = 'var(--teal)';
            addMoreHint.style.fontWeight = 'normal';
        }
        
        // Sync hidden file input for form submission (DataTransfer)
        syncFileInputWithSelectedFiles();
    }
    
    // sync multiple files to the native file input (important for FormData)
    function syncFileInputWithSelectedFiles() {
        const dataTransfer = new DataTransfer();
        selectedFiles.forEach(file => {
            dataTransfer.items.add(file);
        });
        fileInput.files = dataTransfer.files;
    }
    
    function removeImageAtIndex(index) {
        if (index >= 0 && index < selectedFiles.length) {
            selectedFiles.splice(index, 1);
            updateGalleryUI();
        }
    }
    
    function clearAllImages() {
        selectedFiles = [];
        updateGalleryUI();
    }
    
    // Validate and add files (respecting max 5, size, type)
    function addFiles(newFiles) {
        let addedCount = 0;
        const currentCount = selectedFiles.length;
        const remainingSlots = 5 - currentCount;
        
        if (remainingSlots <= 0) {
            showToastMessage('❌ You already have 5 images. Please remove some before adding new ones.', true);
            return false;
        }
        
        const filesToAdd = [];
        for (let i = 0; i < Math.min(newFiles.length, remainingSlots); i++) {
            const file = newFiles[i];
            // Validate type
            if (!file.type.startsWith('image/')) {
                showToastMessage(`❌ "${file.name}" is not a valid image file. Skipped.`, true);
                continue;
            }
            // Validate size (5 MB)
            if (file.size > 5 * 1024 * 1024) {
                showToastMessage(`❌ "${file.name}" exceeds 5MB limit. Skipped.`, true);
                continue;
            }
            filesToAdd.push(file);
        }
        
        if (filesToAdd.length === 0) {
            if (newFiles.length > 0) showToastMessage(`⚠️ No valid images added. Check size (<5MB) and format.`, true);
            return false;
        }
        
        selectedFiles.push(...filesToAdd);
        updateGalleryUI();
        
        if (selectedFiles.length === 5) {
            showToastMessage(`✅ Maximum 5 images reached. Gallery full.`, false);
        } else if (filesToAdd.length < newFiles.length) {
            showToastMessage(`⚠️ Only ${filesToAdd.length} out of ${newFiles.length} image(s) added due to limit or validation.`, true);
        }
        return true;
    }
    
    // Drag & Drop handling
    dropZone.addEventListener('dragover', (e) => {
        e.preventDefault();
        dropZone.classList.add('dragover');
    });
    dropZone.addEventListener('dragleave', () => {
        dropZone.classList.remove('dragover');
    });
    dropZone.addEventListener('drop', (e) => {
        e.preventDefault();
        dropZone.classList.remove('dragover');
        if (e.dataTransfer.files && e.dataTransfer.files.length) {
            const fileArray = Array.from(e.dataTransfer.files);
            addFiles(fileArray);
        }
    });
    
    // Click to browse (multiple)
    dropZone.addEventListener('click', () => {
        if (selectedFiles.length >= 5) {
            showToastMessage(`You already have 5 images. Please remove some before adding new ones.`, true);
            return;
        }
        fileInput.click();
    });
    
    fileInput.addEventListener('change', (e) => {
        if (e.target.files && e.target.files.length) {
            const fileArray = Array.from(e.target.files);
            addFiles(fileArray);
            fileInput.value = '';
        }
    });
    
    clearAllBtn.addEventListener('click', () => {
        if (selectedFiles.length > 0 && confirm('Remove all uploaded images?')) {
            clearAllImages();
        }
    });
    
    function resetImageUploader() {
        selectedFiles = [];
        updateGalleryUI();
    }
    
    // ==================== TOAST NOTIFICATION ====================
    function showToastMessage(message, isError = false) {
        // Remove existing toast
        const existingToast = document.querySelector('.toast-notification');
        if (existingToast) {
            existingToast.remove();
        }
        
        const toast = document.createElement('div');
        toast.className = 'toast-notification';
        if (isError) {
            toast.classList.add('error');
        }
        toast.innerHTML = message;
        document.body.appendChild(toast);
        
        setTimeout(() => {
            toast.remove();
        }, 3000);
    }
    
    // ==================== LOAD CATEGORIES FROM DATABASE ====================
    async function loadCategories() {
    try {
        const contextPath = window.location.pathname.substring(0, window.location.pathname.indexOf('/', 1));
        const response = await fetch(contextPath + '/getCategories');
        const categories = await response.json();
        
        const select = document.getElementById('categorySelect');
        select.innerHTML = '<option value="">-- Select Category --</option>';
        
        categories.forEach(cat => {
            const option = document.createElement('option');
            option.value = cat.name;
            option.textContent = cat.name;
            select.appendChild(option);
        });
    } catch (error) {
        console.error('Failed to load categories:', error);
        // Fallback hardcoded categories
        const fallbackCategories = [
            'Road Construction', 'Drainage & Sewage', 'Street Light',
            'Garbage & Sanitation', 'Water Supply', 'Electricity',
            'Healthcare Facility', 'Other Public Service'
        ];
        const select = document.getElementById('categorySelect');
        fallbackCategories.forEach(cat => {
            const option = document.createElement('option');
            option.value = cat;
            option.textContent = cat;
            select.appendChild(option);
        });
    }
}
    
 // ==================== FORM SUBMIT WITH AJAX ====================
    const submitBtn = document.getElementById('submitReportBtn');
    const backBtn = document.getElementById('backBtn');
    const titleInput = document.getElementById('issueTitle');
    const categorySelect = document.getElementById('categorySelect');
    const descTextarea = document.getElementById('issueDesc');
    const locationInput = document.getElementById('issueLocation');

    // Get the context path dynamically
    const contextPath = window.location.pathname.substring(0, window.location.pathname.indexOf('/', 1));

    submitBtn.addEventListener('click', async () => {
        // validation
        const title = titleInput.value.trim();
        const category = categorySelect.value;
        const description = descTextarea.value.trim();
        const location = locationInput.value.trim();
        
        if (!title) {
            showToastMessage('⚠️ Please enter an issue title.', true);
            titleInput.focus();
            return;
        }
        if (!category) {
            showToastMessage('⚠️ Please select a category.', true);
            categorySelect.focus();
            return;
        }
        if (!description) {
            showToastMessage('⚠️ Please describe the issue in detail.', true);
            descTextarea.focus();
            return;
        }
        if (!location) {
            showToastMessage('⚠️ Please provide a location / address.', true);
            locationInput.focus();
            return;
        }
        if (selectedFiles.length === 0) {
            showToastMessage('📸 Please upload at least one image (up to 5 photos).', true);
            return;
        }
        
        // Prepare FormData
        const formData = new FormData();
        formData.append('title', title);
        formData.append('category', category);
        formData.append('description', description);
        formData.append('location', location);
        
        selectedFiles.forEach((file) => {
            formData.append('photos', file);
        });
        
        // Show loading state
        submitBtn.disabled = true;
        submitBtn.textContent = '⏳ Submitting...';
        
        try {
            // Use dynamic context path - THIS IS THE FIX!
            const response = await fetch(contextPath + '/reportIssue', {
                method: 'POST',
                body: formData
            });
            
            console.log('Response status:', response.status);
            
            if (!response.ok) {
                throw new Error(`HTTP ${response.status}: ${response.statusText}`);
            }
            
            const result = await response.json();
            console.log('Response:', result);
            
            if (result.success) {
                showToastMessage('✅ ' + result.message, false);
                // Reset form
                titleInput.value = '';
                categorySelect.value = '';
                descTextarea.value = '';
                locationInput.value = '';
                resetImageUploader();
                
                // Redirect after 2 seconds
                setTimeout(() => {
                    window.location.href = contextPath + '/userDashboard.jsp';
                }, 2000);
            } else {
                showToastMessage('❌ ' + (result.error || 'Failed to submit report'), true);
            }
        } catch (error) {
            console.error('Error:', error);
            showToastMessage('❌ Error: ' + error.message, true);
        } finally {
            submitBtn.disabled = false;
            submitBtn.textContent = 'Submit Report';
        }
    });

    // Back button functionality
    backBtn.addEventListener('click', () => {
        if (confirm('Go back? Any unsaved data will be lost.')) {
            window.history.back();
        }
    });
    
    // Block window default dragover/drop to avoid unwanted behaviors
    window.addEventListener('dragover', (e) => e.preventDefault());
    window.addEventListener('drop', (e) => e.preventDefault());
    
    // Initialize
    document.addEventListener('DOMContentLoaded', () => {
        loadCategories();
        updateGalleryUI();
    });
</script>
</body>
</html>