;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^\s*(?<Last>[-A-Za-z ]+)[.](?<First>[-A-Za-z ]+)(?:[.](?<Middle>[-A-Za-z ]+))?(?:[.](?<Ordinal>[IVX]+))?(?:[.](?<Number>\d{10}))\s*$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "\u00A0\u00A0 \u0085\u0085\u0085  \x9\u0085\u00A0h -.-.-.8099789889\u00A0 "
(define-fun Witness1 () String (seq.++ "\xa0" (seq.++ "\xa0" (seq.++ " " (seq.++ "\x85" (seq.++ "\x85" (seq.++ "\x85" (seq.++ " " (seq.++ " " (seq.++ "\x09" (seq.++ "\x85" (seq.++ "\xa0" (seq.++ "h" (seq.++ " " (seq.++ "-" (seq.++ "." (seq.++ "-" (seq.++ "." (seq.++ "-" (seq.++ "." (seq.++ "8" (seq.++ "0" (seq.++ "9" (seq.++ "9" (seq.++ "7" (seq.++ "8" (seq.++ "9" (seq.++ "8" (seq.++ "8" (seq.++ "9" (seq.++ "\xa0" (seq.++ " " ""))))))))))))))))))))))))))))))))
;witness2: " ny N.-L.Ak.4708625778\u00A0 \u00A0 "
(define-fun Witness2 () String (seq.++ " " (seq.++ "n" (seq.++ "y" (seq.++ " " (seq.++ "N" (seq.++ "." (seq.++ "-" (seq.++ "L" (seq.++ "." (seq.++ "A" (seq.++ "k" (seq.++ "." (seq.++ "4" (seq.++ "7" (seq.++ "0" (seq.++ "8" (seq.++ "6" (seq.++ "2" (seq.++ "5" (seq.++ "7" (seq.++ "7" (seq.++ "8" (seq.++ "\xa0" (seq.++ " " (seq.++ "\xa0" (seq.++ " " "")))))))))))))))))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.* (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0")))))(re.++ (re.+ (re.union (re.range " " " ")(re.union (re.range "-" "-")(re.union (re.range "A" "Z") (re.range "a" "z")))))(re.++ (re.range "." ".")(re.++ (re.+ (re.union (re.range " " " ")(re.union (re.range "-" "-")(re.union (re.range "A" "Z") (re.range "a" "z")))))(re.++ (re.opt (re.++ (re.range "." ".") (re.+ (re.union (re.range " " " ")(re.union (re.range "-" "-")(re.union (re.range "A" "Z") (re.range "a" "z")))))))(re.++ (re.opt (re.++ (re.range "." ".") (re.+ (re.union (re.range "I" "I")(re.union (re.range "V" "V") (re.range "X" "X"))))))(re.++ (re.range "." ".")(re.++ ((_ re.loop 10 10) (re.range "0" "9"))(re.++ (re.* (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0"))))) (str.to_re "")))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
