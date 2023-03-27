;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = (?<Date>(?<Year>\d{4})-(?<Month>\d{2})-(?<Day>\d{2}))(?:T(?<Time>(?<SimpleTime>(?<Hour>\d{2}):(?<Minute>\d{2})(?::(?<Second>\d{2}))?)?(?:\.(?<FractionalSecond>\d{1,7}))?(?<Offset>-\d{2}\:\d{2})?))?
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "4596-82-51T.5271-16:83\'\u00ED"
(define-fun Witness1 () String (str.++ "4" (str.++ "5" (str.++ "9" (str.++ "6" (str.++ "-" (str.++ "8" (str.++ "2" (str.++ "-" (str.++ "5" (str.++ "1" (str.++ "T" (str.++ "." (str.++ "5" (str.++ "2" (str.++ "7" (str.++ "1" (str.++ "-" (str.++ "1" (str.++ "6" (str.++ ":" (str.++ "8" (str.++ "3" (str.++ "'" (str.++ "\u{ed}" "")))))))))))))))))))))))))
;witness2: ">0389-35-89T45:98"
(define-fun Witness2 () String (str.++ ">" (str.++ "0" (str.++ "3" (str.++ "8" (str.++ "9" (str.++ "-" (str.++ "3" (str.++ "5" (str.++ "-" (str.++ "8" (str.++ "9" (str.++ "T" (str.++ "4" (str.++ "5" (str.++ ":" (str.++ "9" (str.++ "8" ""))))))))))))))))))

(assert (= regexA (re.++ (re.++ ((_ re.loop 4 4) (re.range "0" "9"))(re.++ (re.range "-" "-")(re.++ ((_ re.loop 2 2) (re.range "0" "9"))(re.++ (re.range "-" "-") ((_ re.loop 2 2) (re.range "0" "9")))))) (re.opt (re.++ (re.range "T" "T") (re.++ (re.opt (re.++ ((_ re.loop 2 2) (re.range "0" "9"))(re.++ (re.range ":" ":")(re.++ ((_ re.loop 2 2) (re.range "0" "9")) (re.opt (re.++ (re.range ":" ":") ((_ re.loop 2 2) (re.range "0" "9"))))))))(re.++ (re.opt (re.++ (re.range "." ".") ((_ re.loop 1 7) (re.range "0" "9")))) (re.opt (re.++ (re.range "-" "-")(re.++ ((_ re.loop 2 2) (re.range "0" "9"))(re.++ (re.range ":" ":") ((_ re.loop 2 2) (re.range "0" "9")))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
