;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^([A-Z]{2}\s?(\d{2})?(-)?([A-Z]{1}|\d{1})?([A-Z]{1}|\d{1})?( )?(\d{4}))$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "RT\u008584E1889"
(define-fun Witness1 () String (seq.++ "R" (seq.++ "T" (seq.++ "\x85" (seq.++ "8" (seq.++ "4" (seq.++ "E" (seq.++ "1" (seq.++ "8" (seq.++ "8" (seq.++ "9" "")))))))))))
;witness2: "FE\u0085939 8988"
(define-fun Witness2 () String (seq.++ "F" (seq.++ "E" (seq.++ "\x85" (seq.++ "9" (seq.++ "3" (seq.++ "9" (seq.++ " " (seq.++ "8" (seq.++ "9" (seq.++ "8" (seq.++ "8" ""))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.++ ((_ re.loop 2 2) (re.range "A" "Z"))(re.++ (re.opt (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0")))))(re.++ (re.opt ((_ re.loop 2 2) (re.range "0" "9")))(re.++ (re.opt (re.range "-" "-"))(re.++ (re.opt (re.union (re.range "0" "9") (re.range "A" "Z")))(re.++ (re.opt (re.union (re.range "0" "9") (re.range "A" "Z")))(re.++ (re.opt (re.range " " " ")) ((_ re.loop 4 4) (re.range "0" "9"))))))))) (str.to_re "")))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
