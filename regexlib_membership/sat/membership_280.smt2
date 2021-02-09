;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^([a-zA-Z]:\\)?[^\x00-\x1F"<>\|:\*\?/]+\.[a-zA-Z]{3,4}$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "Q:\\u00B0F3.YPwA"
(define-fun Witness1 () String (seq.++ "Q" (seq.++ ":" (seq.++ "\x5c" (seq.++ "\xb0" (seq.++ "F" (seq.++ "3" (seq.++ "." (seq.++ "Y" (seq.++ "P" (seq.++ "w" (seq.++ "A" ""))))))))))))
;witness2: "Z:\\u0098\u0099\u00EE.VHCM"
(define-fun Witness2 () String (seq.++ "Z" (seq.++ ":" (seq.++ "\x5c" (seq.++ "\x98" (seq.++ "\x99" (seq.++ "\xee" (seq.++ "." (seq.++ "V" (seq.++ "H" (seq.++ "C" (seq.++ "M" ""))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.opt (re.++ (re.union (re.range "A" "Z") (re.range "a" "z")) (str.to_re (seq.++ ":" (seq.++ "\x5c" "")))))(re.++ (re.+ (re.union (re.range " " "!")(re.union (re.range "#" ")")(re.union (re.range "+" ".")(re.union (re.range "0" "9")(re.union (re.range ";" ";")(re.union (re.range "=" "=")(re.union (re.range "@" "{") (re.range "}" "\xff")))))))))(re.++ (re.range "." ".")(re.++ ((_ re.loop 3 4) (re.union (re.range "A" "Z") (re.range "a" "z"))) (str.to_re ""))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
