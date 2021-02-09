;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = (^([0-9]+[.]+[0-9]+)|(0)$)
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "0"
(define-fun Witness1 () String (seq.++ "0" ""))
;witness2: "9.98\u00CA5\xA\u0092"
(define-fun Witness2 () String (seq.++ "9" (seq.++ "." (seq.++ "9" (seq.++ "8" (seq.++ "\xca" (seq.++ "5" (seq.++ "\x0a" (seq.++ "\x92" "")))))))))

(assert (= regexA (re.union (re.++ (str.to_re "") (re.++ (re.+ (re.range "0" "9"))(re.++ (re.+ (re.range "." ".")) (re.+ (re.range "0" "9"))))) (re.++ (re.range "0" "0") (str.to_re "")))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
