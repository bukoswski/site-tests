document.getElementById("loginForm").addEventListener("submit", function(event) {
    const email = document.getElementById("email").value;
    const senha = document.getElementById("senha").value;

    // Validação simples
    if (email.trim() === "" || senha.trim() === "") {
        alert("Por favor, preencha todos os campos.");
        event.preventDefault();
        return;
    }

    // Verificação de e-mail básico
    if (!validateEmail(email)) {
        alert("Por favor, insira um e-mail válido.");
        event.preventDefault();
    }
});

function validateEmail(email) {
    const re = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
    return re.test(email);
}
