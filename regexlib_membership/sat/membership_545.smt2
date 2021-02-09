;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^(http\:\/\/(?:www\.)?[a-zA-Z0-9]+(?:(?:\-|_)[a-zA-Z0-9]+)*(?:\.[a-zA-Z0-9]+(?:(?:\-|_)[a-zA-Z0-9]+)*)*\.[a-zA-Z]{2,4}(?:\/)?)$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "http://www.t90w.z8XDA-e.ze/"
(define-fun Witness1 () String (seq.++ "h" (seq.++ "t" (seq.++ "t" (seq.++ "p" (seq.++ ":" (seq.++ "/" (seq.++ "/" (seq.++ "w" (seq.++ "w" (seq.++ "w" (seq.++ "." (seq.++ "t" (seq.++ "9" (seq.++ "0" (seq.++ "w" (seq.++ "." (seq.++ "z" (seq.++ "8" (seq.++ "X" (seq.++ "D" (seq.++ "A" (seq.++ "-" (seq.++ "e" (seq.++ "." (seq.++ "z" (seq.++ "e" (seq.++ "/" ""))))))))))))))))))))))))))))
;witness2: "http://4_7-AZ_7.GA9yY8_z-8.2YY.xX/"
(define-fun Witness2 () String (seq.++ "h" (seq.++ "t" (seq.++ "t" (seq.++ "p" (seq.++ ":" (seq.++ "/" (seq.++ "/" (seq.++ "4" (seq.++ "_" (seq.++ "7" (seq.++ "-" (seq.++ "A" (seq.++ "Z" (seq.++ "_" (seq.++ "7" (seq.++ "." (seq.++ "G" (seq.++ "A" (seq.++ "9" (seq.++ "y" (seq.++ "Y" (seq.++ "8" (seq.++ "_" (seq.++ "z" (seq.++ "-" (seq.++ "8" (seq.++ "." (seq.++ "2" (seq.++ "Y" (seq.++ "Y" (seq.++ "." (seq.++ "x" (seq.++ "X" (seq.++ "/" "")))))))))))))))))))))))))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.++ (str.to_re (seq.++ "h" (seq.++ "t" (seq.++ "t" (seq.++ "p" (seq.++ ":" (seq.++ "/" (seq.++ "/" ""))))))))(re.++ (re.opt (str.to_re (seq.++ "w" (seq.++ "w" (seq.++ "w" (seq.++ "." ""))))))(re.++ (re.+ (re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z"))))(re.++ (re.* (re.++ (re.union (re.range "-" "-") (re.range "_" "_")) (re.+ (re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z"))))))(re.++ (re.* (re.++ (re.range "." ".")(re.++ (re.+ (re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z")))) (re.* (re.++ (re.union (re.range "-" "-") (re.range "_" "_")) (re.+ (re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z")))))))))(re.++ (re.range "." ".")(re.++ ((_ re.loop 2 4) (re.union (re.range "A" "Z") (re.range "a" "z"))) (re.opt (re.range "/" "/"))))))))) (str.to_re "")))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
