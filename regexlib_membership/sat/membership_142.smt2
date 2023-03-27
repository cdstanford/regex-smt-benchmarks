;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^(.)+\.(jpg|jpeg|JPG|JPEG)$
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "\u00A3.jpeg"
(define-fun Witness1 () String (str.++ "\u{a3}" (str.++ "." (str.++ "j" (str.++ "p" (str.++ "e" (str.++ "g" "")))))))
;witness2: "\u00A4M.jpeg"
(define-fun Witness2 () String (str.++ "\u{a4}" (str.++ "M" (str.++ "." (str.++ "j" (str.++ "p" (str.++ "e" (str.++ "g" ""))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.+ (re.union (re.range "\u{00}" "\u{09}") (re.range "\u{0b}" "\u{ff}")))(re.++ (re.range "." ".")(re.++ (re.union (str.to_re (str.++ "j" (str.++ "p" (str.++ "g" ""))))(re.union (str.to_re (str.++ "j" (str.++ "p" (str.++ "e" (str.++ "g" "")))))(re.union (str.to_re (str.++ "J" (str.++ "P" (str.++ "G" "")))) (str.to_re (str.++ "J" (str.++ "P" (str.++ "E" (str.++ "G" "")))))))) (str.to_re "")))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
