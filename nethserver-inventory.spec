Summary: NethServer ARDAD
Name: nethserver-inventory
Version: 0.0.1
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

