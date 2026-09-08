if (registro.isNotEmpty()) {
    Text(
        text = "LIBRO REGISTRADO",
        fontSize = 18.sp,
        fontWeight = FontWeight.Bold,
        color = Black
    )

    Row(
        Modifier
            .fillMaxWidth()
            .background(Mint, RoundedCornerShape(12.dp))
            .padding(12.dp)
    ) {
        Text("TÍTULO", Modifier.weight(1.5f), fontWeight = FontWeight.Bold, color = Black)
        Text("AUTOR", Modifier.weight(1.5f), fontWeight = FontWeight.Bold, color = Black)
        Text("PÁGINAS", Modifier.weight(1f), fontWeight = FontWeight.Bold, color = Black)
    }

    Row(
        Modifier
            .fillMaxWidth()
            .background(Surface, RoundedCornerShape(12.dp))
            .padding(12.dp)
    ) {
        Text(titulo, Modifier.weight(1.5f), color = Black)
        Text(autor, Modifier.weight(1.5f), color = Black)
        Text(paginas, Modifier.weight(1f), color = Black)
    }
}