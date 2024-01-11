# Ruta de la carpeta temporal
$carpetaTemporal = "C:\CarpetaTemporal"

# Obtener todos los dispositivos USB conectados
$dispositivosUSB = Get-WmiObject Win32_DiskDrive | Where-Object { $_.InterfaceType -eq 'USB' }

# Verifica si se encontraron dispositivos USB
if ($dispositivosUSB) {
    # Creamos la carpeta temporal si no existe
    if (-not (Test-Path $carpetaTemporal)) {
        New-Item -ItemType Directory -Path $carpetaTemporal | Out-Null
    }

    # Copia el contenido de cada dispositivo USB encontrado en la carpeta temporal
    foreach ($dispositivo in $dispositivosUSB) {
        $letraUnidad = $dispositivo.DeviceID.Substring(0, 2)
        $rutaOrigen = "{0}\*" -f $letraUnidad
        Copy-Item -Path $rutaOrigen -Destination $carpetaTemporal -Recurse -Force
    }

    Write-Host "Se ha copiado el contenido de los dispositivos USB conectados en la carpeta temporal."
} else {
    Write-Host "No se encontraron dispositivos USB conectados."
}
