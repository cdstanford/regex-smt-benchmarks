;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^(([A-Z])([a-zA-Z0-9]+)?)(\:)(\d+)$
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "Zr:6"
(define-fun Witness1 () String (str.++ "Z" (str.++ "r" (str.++ ":" (str.++ "6" "")))))
;witness2: "AE:54048"
(define-fun Witness2 () String (str.++ "A" (str.++ "E" (str.++ ":" (str.++ "5" (str.++ "4" (str.++ "0" (str.++ "4" (str.++ "8" "")))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.++ (re.range "A" "Z") (re.opt (re.+ (re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z"))))))(re.++ (re.range ":" ":")(re.++ (re.+ (re.range "0" "9")) (str.to_re "")))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
