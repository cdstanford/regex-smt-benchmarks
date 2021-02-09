;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = [a-zA-Z]{3,}://[a-zA-Z0-9\.]+/*[a-zA-Z0-9/\\%_.]*\?*[a-zA-Z0-9/\\%_.=&amp;]*
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "qxfzPeKZ://.i%I"
(define-fun Witness1 () String (seq.++ "q" (seq.++ "x" (seq.++ "f" (seq.++ "z" (seq.++ "P" (seq.++ "e" (seq.++ "K" (seq.++ "Z" (seq.++ ":" (seq.++ "/" (seq.++ "/" (seq.++ "." (seq.++ "i" (seq.++ "%" (seq.++ "I" ""))))))))))))))))
;witness2: "IyYs://Q\u00F2"
(define-fun Witness2 () String (seq.++ "I" (seq.++ "y" (seq.++ "Y" (seq.++ "s" (seq.++ ":" (seq.++ "/" (seq.++ "/" (seq.++ "Q" (seq.++ "\xf2" ""))))))))))

(assert (= regexA (re.++ (re.++ ((_ re.loop 3 3) (re.union (re.range "A" "Z") (re.range "a" "z"))) (re.* (re.union (re.range "A" "Z") (re.range "a" "z"))))(re.++ (str.to_re (seq.++ ":" (seq.++ "/" (seq.++ "/" ""))))(re.++ (re.+ (re.union (re.range "." ".")(re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z")))))(re.++ (re.* (re.range "/" "/"))(re.++ (re.* (re.union (re.range "%" "%")(re.union (re.range "." "9")(re.union (re.range "A" "Z")(re.union (re.range "\x5c" "\x5c")(re.union (re.range "_" "_") (re.range "a" "z")))))))(re.++ (re.* (re.range "?" "?")) (re.* (re.union (re.range "%" "&")(re.union (re.range "." "9")(re.union (re.range ";" ";")(re.union (re.range "=" "=")(re.union (re.range "A" "Z")(re.union (re.range "\x5c" "\x5c")(re.union (re.range "_" "_") (re.range "a" "z")))))))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
