fetch('eleonoratop.html')
    .then(response => response.text())
    .then(data => document.getElementById("topbar").innerHTML = data);