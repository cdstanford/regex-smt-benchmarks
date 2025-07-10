;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^([a-zA-Z]:\\)?[^\x00-\x1F"<>\|:\*\?/]+\.[a-zA-Z]{3,4}$
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "Q:\\u00B0F3.YPwA"
(define-fun Witness1 () String (str.++ "Q" (str.++ ":" (str.++ "\u{5c}" (str.++ "\u{b0}" (str.++ "F" (str.++ "3" (str.++ "." (str.++ "Y" (str.++ "P" (str.++ "w" (str.++ "A" ""))))))))))))
;witness2: "Z:\\u0098\u0099\u00EE.VHCM"
(define-fun Witness2 () String (str.++ "Z" (str.++ ":" (str.++ "\u{5c}" (str.++ "\u{98}" (str.++ "\u{99}" (str.++ "\u{ee}" (str.++ "." (str.++ "V" (str.++ "H" (str.++ "C" (str.++ "M" ""))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.opt (re.++ (re.union (re.range "A" "Z") (re.range "a" "z")) (str.to_re (str.++ ":" (str.++ "\u{5c}" "")))))(re.++ (re.+ (re.union (re.range " " "!")(re.union (re.range "#" ")")(re.union (re.range "+" ".")(re.union (re.range "0" "9")(re.union (re.range ";" ";")(re.union (re.range "=" "=")(re.union (re.range "@" "{") (re.range "}" "\u{ff}")))))))))(re.++ (re.range "." ".")(re.++ ((_ re.loop 3 4) (re.union (re.range "A" "Z") (re.range "a" "z"))) (str.to_re ""))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
