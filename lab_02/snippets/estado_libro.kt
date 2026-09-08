val context = LocalContext.current

var titulo by remember { mutableStateOf("") }
var autor by remember { mutableStateOf("") }
var paginas by remember { mutableStateOf("") }
var registro by remember { mutableStateOf("") }