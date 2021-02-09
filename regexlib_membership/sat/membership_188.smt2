;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^[\d]{5}[-\s]{1}[\d]{2}[-\s]{1}[\d]{2}[-\s]{1}[\d]{2}$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "60437\u008500-83 80"
(define-fun Witness1 () String (seq.++ "6" (seq.++ "0" (seq.++ "4" (seq.++ "3" (seq.++ "7" (seq.++ "\x85" (seq.++ "0" (seq.++ "0" (seq.++ "-" (seq.++ "8" (seq.++ "3" (seq.++ " " (seq.++ "8" (seq.++ "0" "")))))))))))))))
;witness2: "08984\xA78\xD98\xD99"
(define-fun Witness2 () String (seq.++ "0" (seq.++ "8" (seq.++ "9" (seq.++ "8" (seq.++ "4" (seq.++ "\x0a" (seq.++ "7" (seq.++ "8" (seq.++ "\x0d" (seq.++ "9" (seq.++ "8" (seq.++ "\x0d" (seq.++ "9" (seq.++ "9" "")))))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ ((_ re.loop 5 5) (re.range "0" "9"))(re.++ (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "-" "-")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0")))))(re.++ ((_ re.loop 2 2) (re.range "0" "9"))(re.++ (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "-" "-")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0")))))(re.++ ((_ re.loop 2 2) (re.range "0" "9"))(re.++ (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "-" "-")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0")))))(re.++ ((_ re.loop 2 2) (re.range "0" "9")) (str.to_re "")))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
