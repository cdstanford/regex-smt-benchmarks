;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = [0-9]{4}[0-3]{1}[0-9}{1}[0-9]{5}
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "95981986}8"
(define-fun Witness1 () String (seq.++ "9" (seq.++ "5" (seq.++ "9" (seq.++ "8" (seq.++ "1" (seq.++ "9" (seq.++ "8" (seq.++ "6" (seq.++ "}" (seq.++ "8" "")))))))))))
;witness2: "569829[5{8\u00ED"
(define-fun Witness2 () String (seq.++ "5" (seq.++ "6" (seq.++ "9" (seq.++ "8" (seq.++ "2" (seq.++ "9" (seq.++ "[" (seq.++ "5" (seq.++ "{" (seq.++ "8" (seq.++ "\xed" ""))))))))))))

(assert (= regexA (re.++ ((_ re.loop 4 4) (re.range "0" "9"))(re.++ (re.range "0" "3") ((_ re.loop 5 5) (re.union (re.range "0" "9")(re.union (re.range "[" "[")(re.union (re.range "{" "{") (re.range "}" "}")))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
