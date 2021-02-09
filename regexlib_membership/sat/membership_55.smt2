;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^(?:[a-z0-9][\w\-]*[a-z0-9]*\.)*(?:(?:(?:[a-z0-9][\w\-]*[a-z0-9]*)(?:\.[a-z0-9]+)?)|(?:(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)))$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "8s.8n3.2.248.253.4.254"
(define-fun Witness1 () String (seq.++ "8" (seq.++ "s" (seq.++ "." (seq.++ "8" (seq.++ "n" (seq.++ "3" (seq.++ "." (seq.++ "2" (seq.++ "." (seq.++ "2" (seq.++ "4" (seq.++ "8" (seq.++ "." (seq.++ "2" (seq.++ "5" (seq.++ "3" (seq.++ "." (seq.++ "4" (seq.++ "." (seq.++ "2" (seq.++ "5" (seq.++ "4" "")))))))))))))))))))))))
;witness2: "8z2.4g.wm828"
(define-fun Witness2 () String (seq.++ "8" (seq.++ "z" (seq.++ "2" (seq.++ "." (seq.++ "4" (seq.++ "g" (seq.++ "." (seq.++ "w" (seq.++ "m" (seq.++ "8" (seq.++ "2" (seq.++ "8" "")))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.* (re.++ (re.union (re.range "0" "9") (re.range "a" "z"))(re.++ (re.* (re.union (re.range "-" "-")(re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\xaa" "\xaa")(re.union (re.range "\xb5" "\xb5")(re.union (re.range "\xba" "\xba")(re.union (re.range "\xc0" "\xd6")(re.union (re.range "\xd8" "\xf6") (re.range "\xf8" "\xff"))))))))))))(re.++ (re.* (re.union (re.range "0" "9") (re.range "a" "z"))) (re.range "." ".")))))(re.++ (re.union (re.++ (re.union (re.range "0" "9") (re.range "a" "z"))(re.++ (re.* (re.union (re.range "-" "-")(re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\xaa" "\xaa")(re.union (re.range "\xb5" "\xb5")(re.union (re.range "\xba" "\xba")(re.union (re.range "\xc0" "\xd6")(re.union (re.range "\xd8" "\xf6") (re.range "\xf8" "\xff"))))))))))))(re.++ (re.* (re.union (re.range "0" "9") (re.range "a" "z"))) (re.opt (re.++ (re.range "." ".") (re.+ (re.union (re.range "0" "9") (re.range "a" "z")))))))) (re.++ ((_ re.loop 3 3) (re.++ (re.union (re.++ (str.to_re (seq.++ "2" (seq.++ "5" ""))) (re.range "0" "5"))(re.union (re.++ (re.range "2" "2")(re.++ (re.range "0" "4") (re.range "0" "9"))) (re.++ (re.opt (re.range "0" "1"))(re.++ (re.range "0" "9") (re.opt (re.range "0" "9")))))) (re.range "." "."))) (re.union (re.++ (str.to_re (seq.++ "2" (seq.++ "5" ""))) (re.range "0" "5"))(re.union (re.++ (re.range "2" "2")(re.++ (re.range "0" "4") (re.range "0" "9"))) (re.++ (re.opt (re.range "0" "1"))(re.++ (re.range "0" "9") (re.opt (re.range "0" "9")))))))) (str.to_re ""))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
