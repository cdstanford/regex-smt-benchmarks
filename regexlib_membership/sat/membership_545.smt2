;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^(http\:\/\/(?:www\.)?[a-zA-Z0-9]+(?:(?:\-|_)[a-zA-Z0-9]+)*(?:\.[a-zA-Z0-9]+(?:(?:\-|_)[a-zA-Z0-9]+)*)*\.[a-zA-Z]{2,4}(?:\/)?)$
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "http://www.t90w.z8XDA-e.ze/"
(define-fun Witness1 () String (str.++ "h" (str.++ "t" (str.++ "t" (str.++ "p" (str.++ ":" (str.++ "/" (str.++ "/" (str.++ "w" (str.++ "w" (str.++ "w" (str.++ "." (str.++ "t" (str.++ "9" (str.++ "0" (str.++ "w" (str.++ "." (str.++ "z" (str.++ "8" (str.++ "X" (str.++ "D" (str.++ "A" (str.++ "-" (str.++ "e" (str.++ "." (str.++ "z" (str.++ "e" (str.++ "/" ""))))))))))))))))))))))))))))
;witness2: "http://4_7-AZ_7.GA9yY8_z-8.2YY.xX/"
(define-fun Witness2 () String (str.++ "h" (str.++ "t" (str.++ "t" (str.++ "p" (str.++ ":" (str.++ "/" (str.++ "/" (str.++ "4" (str.++ "_" (str.++ "7" (str.++ "-" (str.++ "A" (str.++ "Z" (str.++ "_" (str.++ "7" (str.++ "." (str.++ "G" (str.++ "A" (str.++ "9" (str.++ "y" (str.++ "Y" (str.++ "8" (str.++ "_" (str.++ "z" (str.++ "-" (str.++ "8" (str.++ "." (str.++ "2" (str.++ "Y" (str.++ "Y" (str.++ "." (str.++ "x" (str.++ "X" (str.++ "/" "")))))))))))))))))))))))))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.++ (str.to_re (str.++ "h" (str.++ "t" (str.++ "t" (str.++ "p" (str.++ ":" (str.++ "/" (str.++ "/" ""))))))))(re.++ (re.opt (str.to_re (str.++ "w" (str.++ "w" (str.++ "w" (str.++ "." ""))))))(re.++ (re.+ (re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z"))))(re.++ (re.* (re.++ (re.union (re.range "-" "-") (re.range "_" "_")) (re.+ (re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z"))))))(re.++ (re.* (re.++ (re.range "." ".")(re.++ (re.+ (re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z")))) (re.* (re.++ (re.union (re.range "-" "-") (re.range "_" "_")) (re.+ (re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z")))))))))(re.++ (re.range "." ".")(re.++ ((_ re.loop 2 4) (re.union (re.range "A" "Z") (re.range "a" "z"))) (re.opt (re.range "/" "/"))))))))) (str.to_re "")))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
