package com.aeu.fieldlog.androidapp

import android.os.Bundle
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.compose.foundation.layout.*
import androidx.compose.material3.*
import androidx.compose.runtime.*
import androidx.compose.ui.Modifier
import androidx.compose.ui.unit.dp
import androidx.lifecycle.viewmodel.compose.viewModel
import com.aeu.fieldlog.shared.*
import kotlinx.coroutines.launch

class MainActivity : ComponentActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContent {
            MaterialTheme {
                Surface(modifier = Modifier.fillMaxSize()) {
                    // Without this the first row draws underneath the status
                    // bar. Compose does not inset for you.
                    LogsScreen(modifier = Modifier.safeDrawingPadding())
                }
            }
        }
    }
}

@Composable
fun LogsScreen(modifier: Modifier = Modifier) {
    val service = remember { LogsService(FakeLogsRepository()) }
    var entries by remember { mutableStateOf<List<LogEntry>>(emptyList()) }
    var loading by remember { mutableStateOf(false) }
    val scope = rememberCoroutineScope()

    Column(modifier = modifier.padding(16.dp)) {
        Text("Platform: ${Platform().name}", style = MaterialTheme.typography.bodySmall)
        Spacer(modifier = Modifier.height(8.dp))
        Button(onClick = {
            scope.launch {
                loading = true
                val result = service.loadAll()
                if (result is Result.Success) entries = result.value
                loading = false
            }
        }) { Text("Load") }

        if (loading) {
            CircularProgressIndicator(modifier = Modifier.padding(top = 16.dp))
        } else {
            entries.forEach { e ->
                Card(modifier = Modifier.fillMaxWidth().padding(top = 8.dp)) {
                    Column(modifier = Modifier.padding(12.dp)) {
                        Text(e.title, style = MaterialTheme.typography.titleMedium)
                        Text(e.body, style = MaterialTheme.typography.bodyMedium)
                        Text(
                            e.category.uppercase(),
                            style = MaterialTheme.typography.labelSmall,
                            modifier = Modifier.padding(top = 4.dp),
                        )
                    }
                }
            }
        }
    }
}
