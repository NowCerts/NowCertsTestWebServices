<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="SearchInsureds.aspx.cs" Inherits="TestNowCertsAPI.SearchInsureds" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <br />
    Authentication Status:
    <asp:Label ID="ltrAuthenticationStatus" runat="server"></asp:Label>

    <div>
        <h3>Search Insureds</h3>
        <div class="filter">
            <div class="caption">
                <span>Type</span>
            </div>
            <div class="control">
                <asp:DropDownList ID="ddlType" runat="server" CssClass="ddl-type">
                    <asp:ListItem Text="Commercial" Value="0" Selected="True"></asp:ListItem>
                    <asp:ListItem Text="Personal" Value="1"></asp:ListItem>
                </asp:DropDownList>
            </div>
        </div>

        <div class="filter only-commercial">
            <div class="caption">
                <span>Commercial Name</span>
            </div>
            <div class="control">
                <asp:TextBox ID="txtCommercialName" class="txt-commercial-name" runat="server"></asp:TextBox>
            </div>
        </div>

        <div class="filter only-personal">
            <div class="caption">
                <span>First Name</span>
            </div>
            <div class="control">
                <asp:TextBox ID="txtFirstName" class="txt-first-name" runat="server"></asp:TextBox>
            </div>
        </div>

        <div class="filter only-personal">
            <div class="caption">
                <span>Last Name</span>
            </div>
            <div class="control">
                <asp:TextBox ID="txtLastName" class="txt-last-name" runat="server"></asp:TextBox>
            </div>
        </div>

        <div class="filter">
            <div class="caption">
                <span>E-mail</span>
            </div>
            <div class="control">
                <asp:TextBox ID="txtEmail" class="txt-email" runat="server"></asp:TextBox>
            </div>
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
                    <asp:ListItem Text="Type" Value="type" Selected="True"></asp:ListItem>
                    <asp:ListItem Text="Email" Value="email"></asp:ListItem>
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
                    <asp:ListItem Text="Commercial Name" Value="commercialName"></asp:ListItem>
                    <asp:ListItem Text="First Name" Value="firstName"></asp:ListItem>
                    <asp:ListItem Text="Last Name" Value="lastName"></asp:ListItem>
                    <asp:ListItem Text="Type" Value="type"></asp:ListItem>
                    <asp:ListItem Text="Email" Value="email"></asp:ListItem>
                    <asp:ListItem Text="Phone" Value="phone"></asp:ListItem>
                    <asp:ListItem Text="City" Value="city"></asp:ListItem>
                    <asp:ListItem Text="State" Value="state"></asp:ListItem>
                    <asp:ListItem Text="Zip" Value="zip"></asp:ListItem>
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
            var $commercialName = $('.txt-commercial-name'),
                $firstName = $('.txt-first-name'),
                $lastName = $('.txt-last-name'),
                $email = $('.txt-email'),
                $type = $('.ddl-type'),
                $chMoreSettings = $('.ch-more-settings'),
                $ddlOrder = $('.ddl-order'),
                $ddlOrderDirection = $('.ddl-order-direction'),
                $skip = $('.txt-skip'),
                $top = $('.txt-top'),
                $btnSearch = $('.btn-search'),
                isCommercial = true,
                isAdvanced = false,
                authorizationData = localStorage.getItem('authorizationData');

            var FILTER_DEFINITION = {
                commercialName: { comparison: 'contains' },
                firstName: { comparison: 'contains' },
                lastName: { comparison: 'contains' },
                email: { comparison: 'contains' },
                type: { comparison: 'eq' }
            };

            // Check for Authorization.
            if (authorizationData) {
                authorizationData = JSON.parse(authorizationData);
                document.getElementById("<%=ltrAuthenticationStatus.ClientID %>").innerHTML = "You are already authenticated.";

                $('.only-settings').hide();
                toggleVisibility();
                insuredTypeChangeHandler();
                insuredMoreSettingsHandler();
                insuredSearchHandler();
            } else {
                document.getElementById("<%=ltrAuthenticationStatus.ClientID %>").innerHTML = "You are not authenticated. Please Authenticate.";
            }

            // Handle Search button click and send the request to NowCerts API.
            function insuredSearchHandler() {
                $btnSearch.on('click', function () {
                    var filter = {};
                    filter.type = $type.val();

                    if ($email.val()) {
                        filter.email = $email.val();
                    }

                    if ($type.val() === '1') {
                        if ($firstName.val()) {
                            filter.firstName = $firstName.val();
                        }

                        if ($lastName.val()) {
                            filter.lastName = $lastName.val();
                        }
                    } else {
                        if ($commercialName.val()) {
                            filter.commercialName = $commercialName.val();
                        }
                    }

                    var base = 'https://api.nowcerts.com/api/InsuredList()?';
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

            // Handle the insured type change event.
            function insuredTypeChangeHandler() {
                $type.on('change', function () {
                    if (this.value === '1') {
                        isCommercial = false;
                    } else {
                        isCommercial = true;
                    }

                    toggleVisibility();
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

            // Toggle visible filters depending on the selected insured type.
            function toggleVisibility() {
                if (isCommercial) {
                    $('.only-commercial').show();
                    $('.only-personal').hide();
                } else {
                    $('.only-commercial').hide();
                    $('.only-personal').show();
                }
            }

            // Get selected properties for additional $select odata statement.
            function getSelectedProperties() {
                result = ['id'];

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
                            collectionEquals.push(`(${properties[i]} eq '${filter[properties[i]]}')`);
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
