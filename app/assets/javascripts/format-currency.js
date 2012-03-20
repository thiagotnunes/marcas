//+ Carlos R. L. Rodrigues
//@ http://jsfromhell.com/forms/format-currency [rev. #3]

function formatCurrency(o, n, dig, dec){
	new function(c, dig, dec, m){
		addEvent(o, "keypress", function(e, _){
			if((_ = e.key == 45) || e.key > 47 && e.key < 58){
				var o = this, d = 0, n, s, h = o.value.charAt(0) == "-" ? "-" : "",
					l = (s = (o.value.replace(/^(-?)0+/g, "$1") + String.fromCharCode(e.key)).replace(/\D/g, "")).length;
				m + 1 && (o.maxLength = m + (d = o.value.length - l + 1));
				if(m + 1 && l >= m && !_) return false;
				l <= (n = c) && (s = new Array(n - l + 2).join("0") + s);
				for(var i = (l = (s = s.split("")).length) - n; (i -= 3) > 0; s[i - 1] += dig);
				n && n < l && (s[l - ++n] += dec);
				_ ? h ? m + 1 && (o.maxLength = m + d) : s[0] = "-" + s[0] : s[0] = h + s[0];
				o.value = s.join("");
			}
			e.key > 30 && e.preventDefault();
		});
	}(!isNaN(n) ? Math.abs(n) : 2, typeof dig != "string" ? "." : dig, typeof dec != "string" ? "," : dec, o.maxLength);
}