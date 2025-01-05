import GoogleAPIClientForREST
import GTMSessionFetcher

func saveToGoogleSheet(qrCodeData: String) {
    // Configure o serviço de autenticação
    let service = GTLRSheetsService()
    service.authorizer = YOUR_AUTHORIZER // Substitua pelo seu autorizador
    
    // Defina a ID da planilha e o intervalo
    let spreadsheetId = "YOUR_SPREADSHEET_ID"
    let range = "Sheet1!A1"  // Altere para o nome da sua planilha e a célula desejada
    let valueRange = GTLRSheets_ValueRange()
    
    // Adiciona os dados do QR Code à planilha
    valueRange.values = [["\(qrCodeData)"]]
    
    // Cria a solicitação para atualizar os dados na planilha
    let query = GTLRSheetsQuery_SpreadsheetsValuesUpdate.query(withObject: valueRange, spreadsheetId: spreadsheetId, range: range)
    query.valueInputOption = "RAW"
    
    // Envia a solicitação
    service.executeQuery(query) { (ticket, result, error) in
        if let error = error {
            print("Erro ao gravar na planilha: \(error)")
        } else {
            print("QR Code salvo na planilha com sucesso!")
        }
    }
}
