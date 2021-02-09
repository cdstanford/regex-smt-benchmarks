;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = \[(?<name>[^\]]*)\](?<value>[^\[]*)
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "[]"
(define-fun Witness1 () String (seq.++ "[" (seq.++ "]" "")))
;witness2: "[\u00C4]\x9\u00FA\u00DF\u00F9"
(define-fun Witness2 () String (seq.++ "[" (seq.++ "\xc4" (seq.++ "]" (seq.++ "\x09" (seq.++ "\xfa" (seq.++ "\xdf" (seq.++ "\xf9" ""))))))))

(assert (= regexA (re.++ (re.range "[" "[")(re.++ (re.* (re.union (re.range "\x00" "\x5c") (re.range "^" "\xff")))(re.++ (re.range "]" "]") (re.* (re.union (re.range "\x00" "Z") (re.range "\x5c" "\xff"))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
