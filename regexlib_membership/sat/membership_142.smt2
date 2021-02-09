;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^(.)+\.(jpg|jpeg|JPG|JPEG)$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "\u00A3.jpeg"
(define-fun Witness1 () String (seq.++ "\xa3" (seq.++ "." (seq.++ "j" (seq.++ "p" (seq.++ "e" (seq.++ "g" "")))))))
;witness2: "\u00A4M.jpeg"
(define-fun Witness2 () String (seq.++ "\xa4" (seq.++ "M" (seq.++ "." (seq.++ "j" (seq.++ "p" (seq.++ "e" (seq.++ "g" ""))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.+ (re.union (re.range "\x00" "\x09") (re.range "\x0b" "\xff")))(re.++ (re.range "." ".")(re.++ (re.union (str.to_re (seq.++ "j" (seq.++ "p" (seq.++ "g" ""))))(re.union (str.to_re (seq.++ "j" (seq.++ "p" (seq.++ "e" (seq.++ "g" "")))))(re.union (str.to_re (seq.++ "J" (seq.++ "P" (seq.++ "G" "")))) (str.to_re (seq.++ "J" (seq.++ "P" (seq.++ "E" (seq.++ "G" "")))))))) (str.to_re "")))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
