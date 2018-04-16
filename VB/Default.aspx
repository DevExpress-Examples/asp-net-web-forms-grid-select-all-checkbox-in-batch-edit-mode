<%@ Page Language="vb" AutoEventWireup="true" CodeFile="Default.aspx.vb" Inherits="_Default" %>

<%@ Register Assembly="DevExpress.Web.v17.1, Version=17.1.4.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web" TagPrefix="dx" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <script type="text/javascript">
        var visibleIndex;
        var DeletedValue;
        function OnInitHeader(s, e) {
            setTimeout(function() { CheckSelectedCellsOnPage("usualCheck"); }, 0);
        }
        function OnHeaderCheckBoxCheckedChanged(s, e) {
            var visibleIndices = Grid.batchEditApi.GetRowVisibleIndices();
            var totalRowsCountOnPage = visibleIndices.length;
            for (var i = 0; i < totalRowsCountOnPage ; i++) {
                Grid.batchEditApi.SetCellValue(visibleIndices[i], "Discontinued", s.GetChecked())
            }
        }
        function OnCellCheckedChanged(s, e) {
            Grid.batchEditApi.EndEdit();
        }

        function OnBatchEditEndEditing(s, e) {
            setTimeout(function() {
                CheckSelectedCellsOnPage("usualCheck");
            }, 0);
        }
        function OnBatchEditRowDeleting(s, e) {
            DeletedValue = Grid.batchEditApi.GetCellValue(e.visibleIndex, "Discontinued");
            CheckSelectedCellsOnPage("deleteCheck");
        }
        function OnBatchEditRowInserting(s, e) {
            CheckSelectedCellsOnPage("insertCheck");
        }

        function CheckSelectedCellsOnPage(checkType) {
            var currentlySelectedRowsCount = 0;
            var visibleIndices = Grid.batchEditApi.GetRowVisibleIndices();
            var totalRowsCountOnPage = visibleIndices.length;
            for (var i = 0; i < totalRowsCountOnPage ; i++) {
                if (Grid.batchEditApi.GetCellValue(visibleIndices[i], "Discontinued"))
                    currentlySelectedRowsCount++;
            }
            if (checkType == "insertCheck")
                totalRowsCountOnPage++;
            else if (checkType == "deleteCheck") {
                totalRowsCountOnPage--;
                if (DeletedValue)
                    currentlySelectedRowsCount--;
            }
            if (currentlySelectedRowsCount <= 0)
                HeaderCheckBox.SetCheckState("Unchecked");
            else if (currentlySelectedRowsCount >= totalRowsCountOnPage)
                HeaderCheckBox.SetCheckState("Checked");
            else
                HeaderCheckBox.SetCheckState("Indeterminate");
        }
    </script>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <dx:ASPxGridView ID="ASPxGridView1" runat="server" DataSourceID="AccessDataSource1" AutoGenerateColumns="False" ClientInstanceName="Grid" KeyFieldName="ProductID"
                OnCustomErrorText="ASPxGridView1_CustomErrorText" OnRowUpdating="ASPxGridView1_RowUpdating">
                <SettingsEditing Mode="Batch">
                </SettingsEditing>
                <ClientSideEvents BatchEditRowDeleting="OnBatchEditRowDeleting" BatchEditEndEditing="OnBatchEditEndEditing"
                    BatchEditRowInserting="OnBatchEditRowInserting" />
                <SettingsPager PageSize="10"></SettingsPager>
                <Columns>
                    <dx:GridViewCommandColumn VisibleIndex="0" ShowNewButtonInHeader="true" ShowDeleteButton="true">
                    </dx:GridViewCommandColumn>
                    <dx:GridViewDataTextColumn FieldName="ProductID" ReadOnly="True" VisibleIndex="1">
                        <EditFormSettings Visible="False" />
                    </dx:GridViewDataTextColumn>
                    <dx:GridViewDataTextColumn FieldName="ProductName" VisibleIndex="2">
                    </dx:GridViewDataTextColumn>
                    <dx:GridViewDataTextColumn FieldName="SupplierID" VisibleIndex="3">
                    </dx:GridViewDataTextColumn>
                    <dx:GridViewDataTextColumn FieldName="CategoryID" VisibleIndex="4">
                    </dx:GridViewDataTextColumn>
                    <dx:GridViewDataTextColumn FieldName="QuantityPerUnit" VisibleIndex="5">
                    </dx:GridViewDataTextColumn>
                    <dx:GridViewDataCheckColumn FieldName="Discontinued" VisibleIndex="6">
                        <PropertiesCheckEdit>
                            <ClientSideEvents CheckedChanged="OnCellCheckedChanged" />
                        </PropertiesCheckEdit>
                        <HeaderTemplate>
                            <dx:ASPxCheckBox ID="HeaderCheckBox" ClientIDMode="Static" runat="server" ClientInstanceName="HeaderCheckBox" AllowGrayed="true" AllowGrayedByClick="false">
                                <ClientSideEvents CheckedChanged="OnHeaderCheckBoxCheckedChanged" Init="OnInitHeader" />
                            </dx:ASPxCheckBox>
                        </HeaderTemplate>
                        <Settings AllowSort="False" />
                    </dx:GridViewDataCheckColumn>
                </Columns>
            </dx:ASPxGridView>
            <asp:AccessDataSource ID="AccessDataSource1" runat="server" DataFile="~/App_Data/nwind.mdb"
                SelectCommand="SELECT [ProductID], [ProductName], [SupplierID], [CategoryID], [QuantityPerUnit], [Discontinued] FROM [Products]"
                UpdateCommand="UPDATE [Products] SET [ProductName] = ?, [SupplierID] = ?, [CategoryID] = ?, [QuantityPerUnit] = ?, [Discontinued] = ? WHERE [ProductID] = ?">
                <UpdateParameters>
                    <asp:Parameter Name="ProductName" Type="String" />
                    <asp:Parameter Name="SupplierID" Type="Int32" />
                    <asp:Parameter Name="CategoryID" Type="Int32" />
                    <asp:Parameter Name="QuantityPerUnit" Type="String" />
                    <asp:Parameter Name="Discontinued" Type="Boolean" />
                    <asp:Parameter Name="ProductID" Type="Int32" />
                </UpdateParameters>
            </asp:AccessDataSource>
        </div>
    </form>
</body>
</html>