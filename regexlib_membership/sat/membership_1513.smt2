;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = %[\-\+0\s\#]{0,1}(\d+){0,1}(\.\d+){0,1}[hlI]{0,1}[cCdiouxXeEfgGnpsS]{1}
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "\u00E6\u00DE\xDp\u00AA%\u00A0lX"
(define-fun Witness1 () String (str.++ "\u{e6}" (str.++ "\u{de}" (str.++ "\u{0d}" (str.++ "p" (str.++ "\u{aa}" (str.++ "%" (str.++ "\u{a0}" (str.++ "l" (str.++ "X" ""))))))))))
;witness2: "^%u"
(define-fun Witness2 () String (str.++ "^" (str.++ "%" (str.++ "u" ""))))

(assert (= regexA (re.++ (re.range "%" "%")(re.++ (re.opt (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "#" "#")(re.union (re.range "+" "+")(re.union (re.range "-" "-")(re.union (re.range "0" "0")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}")))))))))(re.++ (re.opt (re.+ (re.range "0" "9")))(re.++ (re.opt (re.++ (re.range "." ".") (re.+ (re.range "0" "9"))))(re.++ (re.opt (re.union (re.range "I" "I")(re.union (re.range "h" "h") (re.range "l" "l")))) (re.union (re.range "C" "C")(re.union (re.range "E" "E")(re.union (re.range "G" "G")(re.union (re.range "S" "S")(re.union (re.range "X" "X")(re.union (re.range "c" "g")(re.union (re.range "i" "i")(re.union (re.range "n" "p")(re.union (re.range "s" "s")(re.union (re.range "u" "u") (re.range "x" "x"))))))))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
