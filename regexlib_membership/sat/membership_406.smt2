;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^(\+48\s+)?\d{3}(\s*|\-)\d{3}(\s*|\-)\d{3}$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "+48\xD915-295 \u0085\x9\u0085679"
(define-fun Witness1 () String (seq.++ "+" (seq.++ "4" (seq.++ "8" (seq.++ "\x0d" (seq.++ "9" (seq.++ "1" (seq.++ "5" (seq.++ "-" (seq.++ "2" (seq.++ "9" (seq.++ "5" (seq.++ " " (seq.++ "\x85" (seq.++ "\x09" (seq.++ "\x85" (seq.++ "6" (seq.++ "7" (seq.++ "9" "")))))))))))))))))))
;witness2: "+48\u00A0\u0085\u00A0 929904882"
(define-fun Witness2 () String (seq.++ "+" (seq.++ "4" (seq.++ "8" (seq.++ "\xa0" (seq.++ "\x85" (seq.++ "\xa0" (seq.++ " " (seq.++ "9" (seq.++ "2" (seq.++ "9" (seq.++ "9" (seq.++ "0" (seq.++ "4" (seq.++ "8" (seq.++ "8" (seq.++ "2" "")))))))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.opt (re.++ (str.to_re (seq.++ "+" (seq.++ "4" (seq.++ "8" "")))) (re.+ (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0")))))))(re.++ ((_ re.loop 3 3) (re.range "0" "9"))(re.++ (re.union (re.* (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0"))))) (re.range "-" "-"))(re.++ ((_ re.loop 3 3) (re.range "0" "9"))(re.++ (re.union (re.* (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0"))))) (re.range "-" "-"))(re.++ ((_ re.loop 3 3) (re.range "0" "9")) (str.to_re ""))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
