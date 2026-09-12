// 1. Estado de los inputs (capturan lo que escribe el usuario)
var titulo by remember { mutableStateOf("") }
var autor by remember { mutableStateOf("") }
var paginas by remember { mutableStateOf("") }
