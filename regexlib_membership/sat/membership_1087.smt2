;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = [^(\&amp;)](\w*)+(\=)[\w\d ]*
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "+=\u00AA8ay\u00BE3"
(define-fun Witness1 () String (str.++ "+" (str.++ "=" (str.++ "\u{aa}" (str.++ "8" (str.++ "a" (str.++ "y" (str.++ "\u{be}" (str.++ "3" "")))))))))
;witness2: "\u00FF="
(define-fun Witness2 () String (str.++ "\u{ff}" (str.++ "=" "")))

(assert (= regexA (re.++ (re.union (re.range "\u{00}" "%")(re.union (re.range "'" "'")(re.union (re.range "*" ":")(re.union (re.range "<" "`")(re.union (re.range "b" "l")(re.union (re.range "n" "o") (re.range "q" "\u{ff}")))))))(re.++ (re.+ (re.* (re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\u{aa}" "\u{aa}")(re.union (re.range "\u{b5}" "\u{b5}")(re.union (re.range "\u{ba}" "\u{ba}")(re.union (re.range "\u{c0}" "\u{d6}")(re.union (re.range "\u{d8}" "\u{f6}") (re.range "\u{f8}" "\u{ff}"))))))))))))(re.++ (re.range "=" "=") (re.* (re.union (re.range " " " ")(re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\u{aa}" "\u{aa}")(re.union (re.range "\u{b5}" "\u{b5}")(re.union (re.range "\u{ba}" "\u{ba}")(re.union (re.range "\u{c0}" "\u{d6}")(re.union (re.range "\u{d8}" "\u{f6}") (re.range "\u{f8}" "\u{ff}")))))))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
