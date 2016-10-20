Summary: NethServer Inventory
Name: nethserver-inventory
Version: 2.0.2
Release: 1%{?dist}
License: GPL
Source0: %{name}-%{version}.tar.gz
BuildArch: noarch

Requires: puppet-agent
BuildRequires: nethserver-devtools

%description
Inventory based on facter.

%prep
%setup -q

%build

%install
rm -rf %{buildroot}
(cd root ; find . -depth -print | cpio -dump %{buildroot})
%{genfilelist} %{buildroot} > %{name}-%{version}-%{release}-filelist


%files -f %{name}-%{version}-%{release}-filelist
%defattr(-,root,root)
%doc LICENSE

%changelog
* Thu Oct 20 2016 Davide Principi <davide.principi@nethesis.it> - 2.0.2-1
- Gestire i prodotti nethesis nell'inventario e mostrarli su my - Nethesis/dev#5019

* Wed Oct 19 2016 Davide Principi <davide.principi@nethesis.it> - 2.0.1-1
- Fix bad encoding file opening of flashstart plugin

* Thu Sep 22 2016 Giacomo Sanchietti <giacomo.sanchietti@nethesis.it> - 2.0.0-1
- First NS 7 release

* Fri Jul 15 2016 Edoardo Spadoni <edoardo.spadoni@nethesis.it> - 1.0.1-1
- flashstart: read log from yesterday, avoid error if log file doesn not exists
- Add flashstart fact [US #238]

* Fri May 06 2016 Giacomo Sanchietti <giacomo.sanchietti@nethesis.it> - 1.0.0-1
- First public release [NH:4148]


