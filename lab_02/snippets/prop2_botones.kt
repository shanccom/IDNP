// Botones Guardar y Ver registro
Row(
    modifier = Modifier.fillMaxWidth(),
    horizontalArrangement = Arrangement.SpaceEvenly
) {
    Button(onClick = { /* Acción guardar */ }) {
        Text("GUARDAR")
    }
    OutlinedButton(onClick = { /* Acción ver registro */ }) {
        Text("VER REGISTRO")
    }
}
