;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = href\s*=\s*\"((\/)([i])(\/)+([\w\-\.,@?^=%&amp;:/~\+#]*[\w\-\@?^=%&amp;/~\+#]+)*)\"
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "O\u00CEhref=\xD\"/i/\u00AAt\""
(define-fun Witness1 () String (seq.++ "O" (seq.++ "\xce" (seq.++ "h" (seq.++ "r" (seq.++ "e" (seq.++ "f" (seq.++ "=" (seq.++ "\x0d" (seq.++ "\x22" (seq.++ "/" (seq.++ "i" (seq.++ "/" (seq.++ "\xaa" (seq.++ "t" (seq.++ "\x22" ""))))))))))))))))
;witness2: "d\u00B8\u0085\u00CB\u00F7href\u0085=\"/i/~\"\u00AD\u00C1"
(define-fun Witness2 () String (seq.++ "d" (seq.++ "\xb8" (seq.++ "\x85" (seq.++ "\xcb" (seq.++ "\xf7" (seq.++ "h" (seq.++ "r" (seq.++ "e" (seq.++ "f" (seq.++ "\x85" (seq.++ "=" (seq.++ "\x22" (seq.++ "/" (seq.++ "i" (seq.++ "/" (seq.++ "~" (seq.++ "\x22" (seq.++ "\xad" (seq.++ "\xc1" ""))))))))))))))))))))

(assert (= regexA (re.++ (str.to_re (seq.++ "h" (seq.++ "r" (seq.++ "e" (seq.++ "f" "")))))(re.++ (re.* (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0")))))(re.++ (re.range "=" "=")(re.++ (re.* (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0")))))(re.++ (re.range "\x22" "\x22")(re.++ (re.++ (re.range "/" "/")(re.++ (re.range "i" "i")(re.++ (re.+ (re.range "/" "/")) (re.* (re.++ (re.* (re.union (re.range "#" "#")(re.union (re.range "%" "&")(re.union (re.range "+" ";")(re.union (re.range "=" "=")(re.union (re.range "?" "Z")(re.union (re.range "^" "_")(re.union (re.range "a" "z")(re.union (re.range "~" "~")(re.union (re.range "\xaa" "\xaa")(re.union (re.range "\xb5" "\xb5")(re.union (re.range "\xba" "\xba")(re.union (re.range "\xc0" "\xd6")(re.union (re.range "\xd8" "\xf6") (re.range "\xf8" "\xff"))))))))))))))) (re.+ (re.union (re.range "#" "#")(re.union (re.range "%" "&")(re.union (re.range "+" "+")(re.union (re.range "-" "-")(re.union (re.range "/" "9")(re.union (re.range ";" ";")(re.union (re.range "=" "=")(re.union (re.range "?" "Z")(re.union (re.range "^" "_")(re.union (re.range "a" "z")(re.union (re.range "~" "~")(re.union (re.range "\xaa" "\xaa")(re.union (re.range "\xb5" "\xb5")(re.union (re.range "\xba" "\xba")(re.union (re.range "\xc0" "\xd6")(re.union (re.range "\xd8" "\xf6") (re.range "\xf8" "\xff"))))))))))))))))))))))) (re.range "\x22" "\x22")))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
