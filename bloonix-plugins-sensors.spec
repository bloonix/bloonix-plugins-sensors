Summary: Bloonix plugins to check sensors.
Name: bloonix-plugins-sensors
Version: 0.8
Release: 1%{dist}
License: Commercial
Group: Utilities/System
Distribution: RHEL and CentOS

Packager: Jonny Schulz <js@bloonix.de>
Vendor: Bloonix

BuildArch: noarch
BuildRoot: %{_tmppath}/%{name}-%{version}-%{release}-root

Source0: http://download.bloonix.de/sources/%{name}-%{version}.tar.gz
Requires: bloonix-core
Requires: lm_sensors
AutoReqProv: no

%description
bloonix-plugins-sensors provides plugins to check sensors.

%define blxdir /usr/lib/bloonix
%define docdir %{_docdir}/%{name}-%{version}

%prep
%setup -q -n %{name}-%{version}

%build
%{__perl} Configure.PL --prefix /usr
%{__make}

%install
rm -rf %{buildroot}
%{__make} install DESTDIR=%{buildroot}
mkdir -p ${RPM_BUILD_ROOT}%{docdir}
install -c -m 0444 LICENSE ${RPM_BUILD_ROOT}%{docdir}/
install -c -m 0444 ChangeLog ${RPM_BUILD_ROOT}%{docdir}/

%post
if [ ! -e "/etc/bloonix/agent/sudoers.d" ] ; then
    mkdir -p /etc/bloonix/agent/sudoers.d
    chown root:root /etc/bloonix/agent/sudoers.d
    chmod 755 /etc/bloonix/agent/sudoers.d
fi
if [ ! -e "/etc/bloonix/agent/conf.d" ] ; then
    mkdir -p /etc/bloonix/agent/conf.d
    chown root:bloonix /etc/bloonix/agent/conf.d
    chmod 750 /etc/bloonix/agent/conf.d
fi
for f in check-lm-sensors ; do
    if [ ! -e "/etc/bloonix/agent/sudoers.d/$f" ] ; then
        cp -a /usr/lib/bloonix/etc/sudoers.d/$f /etc/bloonix/agent/sudoers.d/
        chmod 440 /etc/bloonix/agent/sudoers.d/$f
    fi
    if [ ! -e "/etc/bloonix/agent/conf.d/$f" ] ; then
        cp -a /usr/lib/bloonix/etc/conf.d/$f.conf /etc/bloonix/agent/conf.d/
        chmod 640 /etc/bloonix/agent/conf.d/$f.conf
        chown root:bloonix /etc/bloonix/agent/conf.d/$f.conf
    fi
done

%clean
rm -rf %{buildroot}

%files
%defattr(-,root,root)

%dir %{blxdir}
%dir %{blxdir}/plugins
%{blxdir}/plugins/check-*
%{blxdir}/etc/plugins/plugin-*

%dir %{blxdir}/etc/sudoers.d
%{blxdir}/etc/sudoers.d/*

%dir %{blxdir}/etc/conf.d
%{blxdir}/etc/conf.d/*

%dir %attr(0755, root, root) %{docdir}
%doc %attr(0444, root, root) %{docdir}/ChangeLog
%doc %attr(0444, root, root) %{docdir}/LICENSE

%changelog
* Tue Aug 18 2015 Jonny Schulz <js@bloonix.de> - 0.8-1
- Kicked the dependency of bloonix-agent.
* Fri Aug 14 2015 Jonny Schulz <js@bloonix.de> - 0.7-1
- Added a configuration file with use_sudo for each check that
  to executed via sudo.
* Thu Aug 13 2015 Jonny Schulz <js@bloonix.de> - 0.6-1
- Added sudoers/check-lm-sensors.
* Mon Nov 03 2014 Jonny Schulz <js@bloonix.de> - 0.5-1
- Updated the license information.
* Tue Aug 26 2014 Jonny Schulz <js@bloonix.de> - 0.4-1
- Licence added and old releases deleted.
* Sat Mar 23 2014 Jonny Schulz <js@bloonix.de> - 0.3-1
- Complete rewrite of all plugins.
* Tue Sep 18 2012 Jonny Schulz <js@bloonix.de> - 0.1-1
- Initial release.
