Summary: NethServer ARDAD
Name: nethserver-inventory
Version: 1.0.1
Release: 1%{?dist}
License: GPL
Source0: %{name}-%{version}.tar.gz
BuildArch: noarch
Requires: facter >= 2.4.6
Requires: rubygem-json
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
* Fri Jul 15 2016 Edoardo Spadoni <edoardo.spadoni@nethesis.it> - 1.0.1-1
- flashstart: read log from yesterday, avoid error if log file doesn not exists
- Add flashstart fact [US #238]

* Fri May 06 2016 Giacomo Sanchietti <giacomo.sanchietti@nethesis.it> - 1.0.0-1
- First public release [NH:4148]


