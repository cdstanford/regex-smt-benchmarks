;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^(http\:\/\/[a-zA-Z0-9\-\.]+\.[a-zA-Z]{2,3}(?:\/\S*)?(?:[a-zA-Z0-9_])+\.(?:jpg|jpeg|gif|png))$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "http://H.EW9.png"
(define-fun Witness1 () String (seq.++ "h" (seq.++ "t" (seq.++ "t" (seq.++ "p" (seq.++ ":" (seq.++ "/" (seq.++ "/" (seq.++ "H" (seq.++ "." (seq.++ "E" (seq.++ "W" (seq.++ "9" (seq.++ "." (seq.++ "p" (seq.++ "n" (seq.++ "g" "")))))))))))))))))
;witness2: "http://5.AgCc.jpg"
(define-fun Witness2 () String (seq.++ "h" (seq.++ "t" (seq.++ "t" (seq.++ "p" (seq.++ ":" (seq.++ "/" (seq.++ "/" (seq.++ "5" (seq.++ "." (seq.++ "A" (seq.++ "g" (seq.++ "C" (seq.++ "c" (seq.++ "." (seq.++ "j" (seq.++ "p" (seq.++ "g" ""))))))))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.++ (str.to_re (seq.++ "h" (seq.++ "t" (seq.++ "t" (seq.++ "p" (seq.++ ":" (seq.++ "/" (seq.++ "/" ""))))))))(re.++ (re.+ (re.union (re.range "-" ".")(re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z")))))(re.++ (re.range "." ".")(re.++ ((_ re.loop 2 3) (re.union (re.range "A" "Z") (re.range "a" "z")))(re.++ (re.opt (re.++ (re.range "/" "/") (re.* (re.union (re.range "\x00" "\x08")(re.union (re.range "\x0e" "\x1f")(re.union (re.range "!" "\x84")(re.union (re.range "\x86" "\x9f") (re.range "\xa1" "\xff"))))))))(re.++ (re.+ (re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_") (re.range "a" "z")))))(re.++ (re.range "." ".") (re.union (str.to_re (seq.++ "j" (seq.++ "p" (seq.++ "g" ""))))(re.union (str.to_re (seq.++ "j" (seq.++ "p" (seq.++ "e" (seq.++ "g" "")))))(re.union (str.to_re (seq.++ "g" (seq.++ "i" (seq.++ "f" "")))) (str.to_re (seq.++ "p" (seq.++ "n" (seq.++ "g" "")))))))))))))) (str.to_re "")))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
