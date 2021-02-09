;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^([a-zA-Z]+)://([a-zA-Z0-9_\-]+)((\.[a-zA-Z0-9_\-]+|[0-9]{1,3})+)\.([a-zA-Z]{2,6}|[0-9]{1,3})((:[0-9]+)?)((/[a-zA-Z0-9_\-,.;=%]*)*)((\?[a-zA-Z0-9_\-,.;=&%]*)?)$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "RzWK://fh980.-s.18"
(define-fun Witness1 () String (seq.++ "R" (seq.++ "z" (seq.++ "W" (seq.++ "K" (seq.++ ":" (seq.++ "/" (seq.++ "/" (seq.++ "f" (seq.++ "h" (seq.++ "9" (seq.++ "8" (seq.++ "0" (seq.++ "." (seq.++ "-" (seq.++ "s" (seq.++ "." (seq.++ "1" (seq.++ "8" "")))))))))))))))))))
;witness2: "s://-8.840:88389?2"
(define-fun Witness2 () String (seq.++ "s" (seq.++ ":" (seq.++ "/" (seq.++ "/" (seq.++ "-" (seq.++ "8" (seq.++ "." (seq.++ "8" (seq.++ "4" (seq.++ "0" (seq.++ ":" (seq.++ "8" (seq.++ "8" (seq.++ "3" (seq.++ "8" (seq.++ "9" (seq.++ "?" (seq.++ "2" "")))))))))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.+ (re.union (re.range "A" "Z") (re.range "a" "z")))(re.++ (str.to_re (seq.++ ":" (seq.++ "/" (seq.++ "/" ""))))(re.++ (re.+ (re.union (re.range "-" "-")(re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_") (re.range "a" "z"))))))(re.++ (re.+ (re.union (re.++ (re.range "." ".") (re.+ (re.union (re.range "-" "-")(re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_") (re.range "a" "z"))))))) ((_ re.loop 1 3) (re.range "0" "9"))))(re.++ (re.range "." ".")(re.++ (re.union ((_ re.loop 2 6) (re.union (re.range "A" "Z") (re.range "a" "z"))) ((_ re.loop 1 3) (re.range "0" "9")))(re.++ (re.opt (re.++ (re.range ":" ":") (re.+ (re.range "0" "9"))))(re.++ (re.* (re.++ (re.range "/" "/") (re.* (re.union (re.range "%" "%")(re.union (re.range "," ".")(re.union (re.range "0" "9")(re.union (re.range ";" ";")(re.union (re.range "=" "=")(re.union (re.range "A" "Z")(re.union (re.range "_" "_") (re.range "a" "z")))))))))))(re.++ (re.opt (re.++ (re.range "?" "?") (re.* (re.union (re.range "%" "&")(re.union (re.range "," ".")(re.union (re.range "0" "9")(re.union (re.range ";" ";")(re.union (re.range "=" "=")(re.union (re.range "A" "Z")(re.union (re.range "_" "_") (re.range "a" "z"))))))))))) (str.to_re "")))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
