;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ICON=[a-zA-Z0-9/\+-;:/-/\"=]*
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "ICON=\u0097"
(define-fun Witness1 () String (str.++ "I" (str.++ "C" (str.++ "O" (str.++ "N" (str.++ "=" (str.++ "\u{97}" "")))))))
;witness2: "gICON=\u00F3"
(define-fun Witness2 () String (str.++ "g" (str.++ "I" (str.++ "C" (str.++ "O" (str.++ "N" (str.++ "=" (str.++ "\u{f3}" ""))))))))

(assert (= regexA (re.++ (str.to_re (str.++ "I" (str.++ "C" (str.++ "O" (str.++ "N" (str.++ "=" "")))))) (re.* (re.union (re.range "\u{22}" "\u{22}")(re.union (re.range "+" ";")(re.union (re.range "=" "=")(re.union (re.range "A" "Z") (re.range "a" "z")))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
