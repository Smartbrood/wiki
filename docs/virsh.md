---
title: "Virsh"
category: "main"
---

== Examples ==
<pre>
virsh list --all
virsh edit frontend2
virsh console frontend2

(exit: Ctrl + ])


virt-viewer --connect qemu+ssh://ubuntu@kvm-host7.poker.wbz.sqtools.ru/system frontend2
</pre>



=== On Guest VM for serial console ===
<pre>
$ sudo systemctl enable serial-getty@ttyS0.service
$ sudo systemctl start serial-getty@ttyS0.service
</pre>