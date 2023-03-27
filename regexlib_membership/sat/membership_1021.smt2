;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^(ES){0,1}([0-9A-Z][0-9]{7}[A-Z])|([A-Z][0-9]{7}[0-9A-Z])$
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "98590298X\u009A"
(define-fun Witness1 () String (str.++ "9" (str.++ "8" (str.++ "5" (str.++ "9" (str.++ "0" (str.++ "2" (str.++ "9" (str.++ "8" (str.++ "X" (str.++ "\u{9a}" "")))))))))))
;witness2: "ESX0398918N{"
(define-fun Witness2 () String (str.++ "E" (str.++ "S" (str.++ "X" (str.++ "0" (str.++ "3" (str.++ "9" (str.++ "8" (str.++ "9" (str.++ "1" (str.++ "8" (str.++ "N" (str.++ "{" "")))))))))))))

(assert (= regexA (re.union (re.++ (str.to_re "")(re.++ (re.opt (str.to_re (str.++ "E" (str.++ "S" "")))) (re.++ (re.union (re.range "0" "9") (re.range "A" "Z"))(re.++ ((_ re.loop 7 7) (re.range "0" "9")) (re.range "A" "Z"))))) (re.++ (re.++ (re.range "A" "Z")(re.++ ((_ re.loop 7 7) (re.range "0" "9")) (re.union (re.range "0" "9") (re.range "A" "Z")))) (str.to_re "")))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
