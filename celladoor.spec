# no post install
#%define __os_install_post %{nil}
# no strip
#%define __strip /bin/true
# no debug package
#%define debug_package %{nil}
# disable automatic dependency processing
#AutoReqProv: no
%define app_name com.cabledogs.cellardoor


Name:           cellardoor
Version: 0.9
Release:        1
License:        GPL v2
Summary:        A wine application journal
Url:            http://cellardoor.googlecode.com
Group:          Amusement
Source0:        %{name}-%{version}.tar.gz
Requires:    libqt >= 4.7.0, qt-mobility >= 1.1
BuildRequires:  libqt-devel

%description
# Add here description of the package.

%prep
%setup -q

%build
# Add here commands to configure the package.
#%qmake
#qmake -makefile -nocache QMAKE_STRIP=: PREFIX=%{_prefix}

# Add here commands to compile the package.
#make %{?jobs:-j%jobs}
#make %{?_smp_mflags}
make

%install
# Add here commands to install the package.
#%qmake_install
make install INSTALL_ROOT=%{buildroot}

%files
%defattr(-,root,root,-)


/opt/%{app_name}
%{_datadir}/applications/*.desktop
%{_datadir}/icons/*.png
%{_datadir}/icons/hicolor/16x16/apps/*.png
%{_datadir}/icons/hicolor/32x32/apps/*.png
%{_datadir}/icons/hicolor/64x64/apps/*.png
%{_datadir}/icons/hicolor/128x128/apps/*.png

/*
