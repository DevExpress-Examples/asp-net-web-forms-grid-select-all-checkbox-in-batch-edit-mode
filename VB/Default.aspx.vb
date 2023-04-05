Imports DevExpress.Web
Imports System
Imports System.Collections.Generic
Imports System.Data
Imports System.Linq
Imports System.Web
Imports System.Web.UI
Imports System.Web.UI.WebControls

Partial Public Class _Default
	Inherits System.Web.UI.Page

	Protected Sub ASPxGridView1_CustomErrorText(ByVal sender As Object, ByVal e As ASPxGridViewCustomErrorTextEventArgs)
		If TypeOf e.Exception Is CallbackException Then
			e.ErrorText = e.Exception.Message
		End If
	End Sub
	Protected Sub ASPxGridView1_RowUpdating(ByVal sender As Object, ByVal e As DevExpress.Web.Data.ASPxDataUpdatingEventArgs)
		Throw New CallbackException("Data modifications are not allowed in the online example")
	End Sub
End Class

Public Class CallbackException
	Inherits Exception

	Public Sub New(ByVal message As String)
		MyBase.New(message)
	End Sub
End Class