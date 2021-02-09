;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^[^\\\./:\*\?\"<>\|]{1}[^\\/:\*\?\"<>\|]{0,254}$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "\u00CFo"
(define-fun Witness1 () String (seq.++ "\xcf" (seq.++ "o" "")))
;witness2: "\u0097l\u00DE"
(define-fun Witness2 () String (seq.++ "\x97" (seq.++ "l" (seq.++ "\xde" ""))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.union (re.range "\x00" "!")(re.union (re.range "#" ")")(re.union (re.range "+" "-")(re.union (re.range "0" "9")(re.union (re.range ";" ";")(re.union (re.range "=" "=")(re.union (re.range "@" "[")(re.union (re.range "]" "{") (re.range "}" "\xff")))))))))(re.++ ((_ re.loop 0 254) (re.union (re.range "\x00" "!")(re.union (re.range "#" ")")(re.union (re.range "+" ".")(re.union (re.range "0" "9")(re.union (re.range ";" ";")(re.union (re.range "=" "=")(re.union (re.range "@" "[")(re.union (re.range "]" "{") (re.range "}" "\xff")))))))))) (str.to_re ""))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
