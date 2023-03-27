;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = href\s*=\s*\"((\/)([i])(\/)+([\w\-\.,@?^=%&amp;:/~\+#]*[\w\-\@?^=%&amp;/~\+#]+)*)\"
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "O\u00CEhref=\xD\"/i/\u00AAt\""
(define-fun Witness1 () String (str.++ "O" (str.++ "\u{ce}" (str.++ "h" (str.++ "r" (str.++ "e" (str.++ "f" (str.++ "=" (str.++ "\u{0d}" (str.++ "\u{22}" (str.++ "/" (str.++ "i" (str.++ "/" (str.++ "\u{aa}" (str.++ "t" (str.++ "\u{22}" ""))))))))))))))))
;witness2: "d\u00B8\u0085\u00CB\u00F7href\u0085=\"/i/~\"\u00AD\u00C1"
(define-fun Witness2 () String (str.++ "d" (str.++ "\u{b8}" (str.++ "\u{85}" (str.++ "\u{cb}" (str.++ "\u{f7}" (str.++ "h" (str.++ "r" (str.++ "e" (str.++ "f" (str.++ "\u{85}" (str.++ "=" (str.++ "\u{22}" (str.++ "/" (str.++ "i" (str.++ "/" (str.++ "~" (str.++ "\u{22}" (str.++ "\u{ad}" (str.++ "\u{c1}" ""))))))))))))))))))))

(assert (= regexA (re.++ (str.to_re (str.++ "h" (str.++ "r" (str.++ "e" (str.++ "f" "")))))(re.++ (re.* (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}")))))(re.++ (re.range "=" "=")(re.++ (re.* (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}")))))(re.++ (re.range "\u{22}" "\u{22}")(re.++ (re.++ (re.range "/" "/")(re.++ (re.range "i" "i")(re.++ (re.+ (re.range "/" "/")) (re.* (re.++ (re.* (re.union (re.range "#" "#")(re.union (re.range "%" "&")(re.union (re.range "+" ";")(re.union (re.range "=" "=")(re.union (re.range "?" "Z")(re.union (re.range "^" "_")(re.union (re.range "a" "z")(re.union (re.range "~" "~")(re.union (re.range "\u{aa}" "\u{aa}")(re.union (re.range "\u{b5}" "\u{b5}")(re.union (re.range "\u{ba}" "\u{ba}")(re.union (re.range "\u{c0}" "\u{d6}")(re.union (re.range "\u{d8}" "\u{f6}") (re.range "\u{f8}" "\u{ff}"))))))))))))))) (re.+ (re.union (re.range "#" "#")(re.union (re.range "%" "&")(re.union (re.range "+" "+")(re.union (re.range "-" "-")(re.union (re.range "/" "9")(re.union (re.range ";" ";")(re.union (re.range "=" "=")(re.union (re.range "?" "Z")(re.union (re.range "^" "_")(re.union (re.range "a" "z")(re.union (re.range "~" "~")(re.union (re.range "\u{aa}" "\u{aa}")(re.union (re.range "\u{b5}" "\u{b5}")(re.union (re.range "\u{ba}" "\u{ba}")(re.union (re.range "\u{c0}" "\u{d6}")(re.union (re.range "\u{d8}" "\u{f6}") (re.range "\u{f8}" "\u{ff}"))))))))))))))))))))))) (re.range "\u{22}" "\u{22}")))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
