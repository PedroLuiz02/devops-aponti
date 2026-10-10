const mensagem = process.env.MENSAGEM_SECRETA;

if (!mensagem) {
    console.error("MENSAGEM_SECRETA não foi configurada.");
    process.exit(1);
}

console.log("Secret recebido pela aplicação com sucesso.");
console.log(`Quantidade de caracteres: ${mensagem.length}`);