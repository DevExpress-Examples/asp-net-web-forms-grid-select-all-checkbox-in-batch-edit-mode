<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="_Default" %>

<%@ Register Assembly="DevExpress.Web.v15.1, Version=15.1.5.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web" TagPrefix="dx" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <script type="text/javascript">
        var visibleIndex;
        function InitHeader(s, e) {
            CheckSelectedCellsOnPage();
        }
        function OnHeaderCheckBoxCheckedChanged(s, e) {
            for (var i = 0; i < Grid.GetVisibleRowsOnPage() ; i++) {
                Grid.batchEditApi.SetCellValue(i + Grid.GetTopVisibleIndex(), "Discontinued", s.GetChecked())
            }
        }
        function OnCellCheckedChanged(s, e) {
            Grid.batchEditApi.SetCellValue(visibleIndex, "Discontinued", s.GetValue());
            CheckSelectedCellsOnPage();
        }

        function OnBatchEditStartEditing(s, e) {
            visibleIndex = e.visibleIndex;
        }

        function CheckSelectedCellsOnPage() {
            var currentlySelectedRowsCount = 0;
            var totalRowsCountOnPage = Grid.GetVisibleRowsOnPage();
            for (var i = 0; i < totalRowsCountOnPage ; i++) {
                if (Grid.batchEditApi.GetCellValue(i + Grid.GetTopVisibleIndex(), "Discontinued"))
                    currentlySelectedRowsCount++;
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
            <dx:ASPxGridView ID="ASPxGridView1" runat="server" DataSourceID="SqlDataSource1" AutoGenerateColumns="False" ClientInstanceName="Grid" KeyFieldName="ProductID"
                OnCustomErrorText="ASPxGridView1_CustomErrorText" OnRowUpdating="ASPxGridView1_RowUpdating">
                <SettingsEditing Mode="Batch"></SettingsEditing>
                <ClientSideEvents BatchEditStartEditing="OnBatchEditStartEditing" />
                <SettingsPager PageSize="20"></SettingsPager>
                <Columns>
                    <dx:GridViewCommandColumn VisibleIndex="0">
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
                            <dx:ASPxCheckBox ID="HeaderCheckBox" runat="server" ClientInstanceName="HeaderCheckBox" AllowGrayed="true" AllowGrayedByClick="false">
                                <ClientSideEvents CheckedChanged="OnHeaderCheckBoxCheckedChanged" Init="InitHeader" />
                            </dx:ASPxCheckBox>
                        </HeaderTemplate>
                        <Settings AllowSort="False" />
                    </dx:GridViewDataCheckColumn>
                </Columns>
            </dx:ASPxGridView>
            <asp:SqlDataSource ID="SqlDataSource1" runat="server"
                SelectCommand="SELECT [ProductID], [ProductName], [SupplierID], [CategoryID], [QuantityPerUnit], [Discontinued] FROM [Products]"
                ConnectionString="<%$ ConnectionStrings:ConnStr %>"
                UpdateCommand="UPDATE [Products] SET [ProductName] = @ProductName, [SupplierID] = @SupplierID, [CategoryID] = @CategoryID, [QuantityPerUnit] = @QuantityPerUnit, [Discontinued] = @Discontinued WHERE [ProductID] = @ProductID">
                <UpdateParameters>
                    <asp:Parameter Name="ProductName" Type="String" />
                    <asp:Parameter Name="SupplierID" Type="Int32" />
                    <asp:Parameter Name="CategoryID" Type="Int32" />
                    <asp:Parameter Name="QuantityPerUnit" Type="String" />
                    <asp:Parameter Name="Discontinued" Type="Boolean" />
                    <asp:Parameter Name="ProductID" Type="Int32" />
                </UpdateParameters>
            </asp:SqlDataSource>
        </div>
    </form>
</body>
</html>
