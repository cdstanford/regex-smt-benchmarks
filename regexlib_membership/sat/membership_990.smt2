;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = (?<Date>(?<Year>\d{4})-(?<Month>\d{2})-(?<Day>\d{2}))(?:T(?<Time>(?<SimpleTime>(?<Hour>\d{2}):(?<Minute>\d{2})(?::(?<Second>\d{2}))?)?(?:\.(?<FractionalSecond>\d{1,7}))?(?<Offset>-\d{2}\:\d{2})?))?
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "4596-82-51T.5271-16:83\'\u00ED"
(define-fun Witness1 () String (seq.++ "4" (seq.++ "5" (seq.++ "9" (seq.++ "6" (seq.++ "-" (seq.++ "8" (seq.++ "2" (seq.++ "-" (seq.++ "5" (seq.++ "1" (seq.++ "T" (seq.++ "." (seq.++ "5" (seq.++ "2" (seq.++ "7" (seq.++ "1" (seq.++ "-" (seq.++ "1" (seq.++ "6" (seq.++ ":" (seq.++ "8" (seq.++ "3" (seq.++ "'" (seq.++ "\xed" "")))))))))))))))))))))))))
;witness2: ">0389-35-89T45:98"
(define-fun Witness2 () String (seq.++ ">" (seq.++ "0" (seq.++ "3" (seq.++ "8" (seq.++ "9" (seq.++ "-" (seq.++ "3" (seq.++ "5" (seq.++ "-" (seq.++ "8" (seq.++ "9" (seq.++ "T" (seq.++ "4" (seq.++ "5" (seq.++ ":" (seq.++ "9" (seq.++ "8" ""))))))))))))))))))

(assert (= regexA (re.++ (re.++ ((_ re.loop 4 4) (re.range "0" "9"))(re.++ (re.range "-" "-")(re.++ ((_ re.loop 2 2) (re.range "0" "9"))(re.++ (re.range "-" "-") ((_ re.loop 2 2) (re.range "0" "9")))))) (re.opt (re.++ (re.range "T" "T") (re.++ (re.opt (re.++ ((_ re.loop 2 2) (re.range "0" "9"))(re.++ (re.range ":" ":")(re.++ ((_ re.loop 2 2) (re.range "0" "9")) (re.opt (re.++ (re.range ":" ":") ((_ re.loop 2 2) (re.range "0" "9"))))))))(re.++ (re.opt (re.++ (re.range "." ".") ((_ re.loop 1 7) (re.range "0" "9")))) (re.opt (re.++ (re.range "-" "-")(re.++ ((_ re.loop 2 2) (re.range "0" "9"))(re.++ (re.range ":" ":") ((_ re.loop 2 2) (re.range "0" "9")))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
