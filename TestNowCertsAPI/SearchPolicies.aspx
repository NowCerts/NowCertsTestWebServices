<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="SearchPolicies.aspx.cs" Inherits="TestNowCertsAPI.SearchPolicies" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <br />
    Authentication Status:
    <asp:Label ID="ltrAuthenticationStatus" runat="server"></asp:Label>

    <div>
        <h3>Search Policies</h3>
        <div class="filter">
            <div class="caption">
                <span>Policy Number</span>
            </div>
            <div class="control">
                <asp:TextBox ID="txtNumber" class="txt-number" runat="server"></asp:TextBox>
            </div>
        </div>

        <div class="filter">
            <asp:CheckBox ID="chIsQuote" runat="server" CssClass="ch-is-quote" Text="Is Quote" />
        </div>

        <div class="filter">
            <asp:CheckBox ID="chMoreSettings" runat="server" CssClass="ch-more-settings" Text="More Settings" />
        </div>

        <div class="filter only-settings">
            <div class="caption">
                <span>Order By</span>
            </div>
            <div class="control">
                <asp:DropDownList ID="ddlOrderBy" runat="server" CssClass="ddl-order">
                    <asp:ListItem Text="" Value=""></asp:ListItem>
                    <asp:ListItem Text="Business Sub Type" Value="businessSubType" Selected="True"></asp:ListItem>
                    <asp:ListItem Text="Effective Date" Value="effectiveDate"></asp:ListItem>
                    <asp:ListItem Text="Expiration Date" Value="expirationDate"></asp:ListItem>
                </asp:DropDownList>
            </div>
        </div>

        <div class="filter only-settings">
            <div class="caption">
                <span>Order Direction</span>
            </div>
            <div class="control">
                <asp:DropDownList ID="ddlOrderDirection" runat="server" CssClass="ddl-order-direction">
                    <asp:ListItem Text="asc" Value="asc" Selected="True"></asp:ListItem>
                    <asp:ListItem Text="desc" Value="desc"></asp:ListItem>
                </asp:DropDownList>
            </div>
        </div>

        <div class="filter only-settings">
            <div class="caption">
                <span>Select Properties</span>
            </div>
            <div class="control">
                <asp:CheckBoxList ID="cblProperties" runat="server" CssClass="chl-properties">
                    <asp:ListItem Text="Expiration Date" Value="expirationDate"></asp:ListItem>
                    <asp:ListItem Text="Effective Date" Value="effectiveDate"></asp:ListItem>
                    <asp:ListItem Text="BindDate" Value="bindDate"></asp:ListItem>
                    <asp:ListItem Text="Business Type" Value="businessType"></asp:ListItem>
                    <asp:ListItem Text="Description" Value="description"></asp:ListItem>
                    <asp:ListItem Text="Insured First Name" Value="insuredFirstName"></asp:ListItem>
                    <asp:ListItem Text="Insured Last Name" Value="insuredLastName"></asp:ListItem>
                    <asp:ListItem Text="Insured Commercial Name" Value="insuredCommercialName"></asp:ListItem>
                    <asp:ListItem Text="Insured Email" Value="insuredEmail"></asp:ListItem>
                </asp:CheckBoxList>
            </div>
        </div>

        <div class="filter only-settings">
            <p>
                If you want to select only a part of the available results (for example for implementing a paging functionality) you can use <strong>$skip</strong> (skip first n entities) & <strong>$top</strong> (take n entities).
                <br />
                <i>You should use this two options always together.</i>
            </p>
        </div>

        <div class="filter only-settings">
            <div class="caption">
                <span>$skip (number)</span>
            </div>
            <div class="control">
                <asp:TextBox ID="txtSkip" class="txt-skip" runat="server"></asp:TextBox>
            </div>
        </div>

        <div class="filter only-settings">
            <div class="caption">
                <span>$top (number)</span>
            </div>
            <div class="control">
                <asp:TextBox ID="txtTop" class="txt-top" runat="server"></asp:TextBox>
            </div>
        </div>

         <div style="margin-top: 15px;">
            <asp:Button ID="btnSearch" class="btn-search" runat="server" Text="Search" OnClientClick="return false;" />
        </div>

        <div style="margin-top: 15px;">
            <strong><asp:Label ID="ltrRequestUrl" runat="server"></asp:Label></strong> <br />
            <asp:Label ID="ltrResultMessage" runat="server"></asp:Label>
        </div>
    </div>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="scripts" runat="server">
    <style>
        .filter {
            margin-bottom: 10px;
        }

        .control,
        .caption {
            display: inline-block;
        }

        .caption {
            width: 130px;
            vertical-align: top;
        }

        label {
            font-weight: normal;
        }
    </style>

    <script>
        $('document').ready(function () {
            var $number = $('.txt-number'),
                $chIsQuote = $('.ch-is-quote');
                $chMoreSettings = $('.ch-more-settings'),
                $ddlOrder = $('.ddl-order'),
                $ddlOrderDirection = $('.ddl-order-direction'),
                $skip = $('.txt-skip'),
                $top = $('.txt-top'),
                $btnSearch = $('.btn-search'),
                isQuote = false,
                isAdvanced = false,
                authorizationData = localStorage.getItem('authorizationData');

            var FILTER_DEFINITION = {
                number: { comparison: 'contains' },
                isQuote: { comparison: 'eq' }
            };

            // Check for Authorization.
            if (authorizationData) {
                authorizationData = JSON.parse(authorizationData);
                document.getElementById("<%=ltrAuthenticationStatus.ClientID %>").innerHTML = "You are already authenticated.";

                $('.only-settings').hide();
                insuredMoreSettingsHandler();
                policyOrQuote();
                insuredSearchHandler();
            } else {
                document.getElementById("<%=ltrAuthenticationStatus.ClientID %>").innerHTML = "You are not authenticated. Please Authenticate.";
            }

            // Handle Search button click and send the request to NowCerts API.
            function insuredSearchHandler() {
                $btnSearch.on('click', function () {
                    var filter = {};

                    if ($number.val()) {
                            filter.number = $number.val();
                    }
                    filter.isQuote = isQuote;

                    var base = '<%=ConfigurationHelper.ApiUrl%>PolicyList()?';
                    var url = constructFilter(filter);
                    var final = `${base}${url}`;

                    if (isAdvanced) {
                        if ($ddlOrder.val()) {
                            final = final + `&$orderby=${$ddlOrder.val()} ${$ddlOrderDirection.val()}`;
                        }

                        if ($skip.val() || $top.val()) {
                            final = final + `&$skip=${parseInt($skip.val()) || 0}&$top=${parseInt($top.val()) || 0}`;
                        }

                        var props = getSelectedProperties();
                        if (props && props.length > 1) {
                            final = final + `&$select=${props.join(',')}`;
                        }
                    }

                    $.ajax({
                        method: "GET",
                        url: final,
                        headers: { 'Authorization': authorizationData.token_type + ' ' + authorizationData.access_token },
                        contentType: 'application/json'
                    })
                        .fail(function (error) {
                            document.getElementById("<%=ltrResultMessage.ClientID %>").innerHTML = `Error. Please try again or re-authenticate.`;
                        })
                        .done(function (result) {
                            if (result) {
                                var insureds = result.value;
                                console.log(insureds);

                                document.getElementById("<%=ltrRequestUrl.ClientID %>").innerHTML = `Request URL: ${final}`;
                                document.getElementById("<%=ltrResultMessage.ClientID %>").innerHTML = `Results were printed in the console. Search found ${insureds.length} matches.`;
                            }
                        });
                });
            }
            
            // Handle the more settings checkbox change event.
            function insuredMoreSettingsHandler() {
                $chMoreSettings.on('change', function () {
                    var value = $(this).find('input')[0].checked;
                    if (value) {
                        isAdvanced = true;
                        $('.only-settings').show();
                    } else {
                        isWithOrder = false;
                        $('.only-settings').hide();
                    }
                });
            }

            // isQuote
            function policyOrQuote() {
                $chIsQuote.on('change', function () {
                    isQuote = $(this).find('input')[0].checked ? true : false;
                });
            }
            
            // Get selected properties for additional $select odata statement.
            function getSelectedProperties() {
                result = ['databaseId'];

                var checks = $('.chl-properties').find('input');

                for (var i = 0; i < checks.length; i++) {
                    if ($(checks[i])[0].checked) {
                        result.push($(checks[i])[0].defaultValue);
                    }
                }

                return result;
            }

            // Construct odata $filter.
            function constructFilter(filter) {
                var result = '$filter=';
                var collectionContains = [];
                var collectionEquals = [];
                var properties = Object.keys(filter);
                
                for (var i = 0; i < properties.length; i++) {
                    var comparisonDef = FILTER_DEFINITION[properties[i]];
                    if (comparisonDef) {
                        if (comparisonDef.comparison === 'contains') {
                            collectionContains.push(`contains(${properties[i]}, '${filter[properties[i]]}')`);
                        }

                        if (comparisonDef.comparison === 'eq') {
                            collectionEquals.push(`(${properties[i]} eq ${filter[properties[i]]})`);
                        }
                    }
                }

                result = result + collectionEquals.join(' and ');

                if (collectionContains.length > 0) {
                    result = result + ' and ' + collectionContains.join(' and ');
                }
                
                return result;
            }
        });
    </script>
</asp:Content>
