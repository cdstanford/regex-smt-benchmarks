;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^([a-zA-Z]+)://([a-zA-Z0-9_\-]+)((\.[a-zA-Z0-9_\-]+|[0-9]{1,3})+)\.([a-zA-Z]{2,6}|[0-9]{1,3})((:[0-9]+)?)((/[a-zA-Z0-9_\-,.;=%]*)*)((\?[a-zA-Z0-9_\-,.;=&%]*)?)$
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "RzWK://fh980.-s.18"
(define-fun Witness1 () String (str.++ "R" (str.++ "z" (str.++ "W" (str.++ "K" (str.++ ":" (str.++ "/" (str.++ "/" (str.++ "f" (str.++ "h" (str.++ "9" (str.++ "8" (str.++ "0" (str.++ "." (str.++ "-" (str.++ "s" (str.++ "." (str.++ "1" (str.++ "8" "")))))))))))))))))))
;witness2: "s://-8.840:88389?2"
(define-fun Witness2 () String (str.++ "s" (str.++ ":" (str.++ "/" (str.++ "/" (str.++ "-" (str.++ "8" (str.++ "." (str.++ "8" (str.++ "4" (str.++ "0" (str.++ ":" (str.++ "8" (str.++ "8" (str.++ "3" (str.++ "8" (str.++ "9" (str.++ "?" (str.++ "2" "")))))))))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.+ (re.union (re.range "A" "Z") (re.range "a" "z")))(re.++ (str.to_re (str.++ ":" (str.++ "/" (str.++ "/" ""))))(re.++ (re.+ (re.union (re.range "-" "-")(re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_") (re.range "a" "z"))))))(re.++ (re.+ (re.union (re.++ (re.range "." ".") (re.+ (re.union (re.range "-" "-")(re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_") (re.range "a" "z"))))))) ((_ re.loop 1 3) (re.range "0" "9"))))(re.++ (re.range "." ".")(re.++ (re.union ((_ re.loop 2 6) (re.union (re.range "A" "Z") (re.range "a" "z"))) ((_ re.loop 1 3) (re.range "0" "9")))(re.++ (re.opt (re.++ (re.range ":" ":") (re.+ (re.range "0" "9"))))(re.++ (re.* (re.++ (re.range "/" "/") (re.* (re.union (re.range "%" "%")(re.union (re.range "," ".")(re.union (re.range "0" "9")(re.union (re.range ";" ";")(re.union (re.range "=" "=")(re.union (re.range "A" "Z")(re.union (re.range "_" "_") (re.range "a" "z")))))))))))(re.++ (re.opt (re.++ (re.range "?" "?") (re.* (re.union (re.range "%" "&")(re.union (re.range "," ".")(re.union (re.range "0" "9")(re.union (re.range ";" ";")(re.union (re.range "=" "=")(re.union (re.range "A" "Z")(re.union (re.range "_" "_") (re.range "a" "z"))))))))))) (str.to_re "")))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
