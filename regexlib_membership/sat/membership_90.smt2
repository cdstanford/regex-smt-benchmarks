;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^(ht|f)tp(s?)\:\/\/(([a-zA-Z0-9\-\._]+(\.[a-zA-Z0-9\-\._]+)+)|localhost)(\/?)([a-zA-Z0-9\-\.\?\,\'\/\\\+&amp;%\$#_]*)?([\d\w\.\/\%\+\-\=\&amp;\?\:\\\&quot;\'\,\|\~\;]*)$
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "https://f.K"
(define-fun Witness1 () String (str.++ "h" (str.++ "t" (str.++ "t" (str.++ "p" (str.++ "s" (str.++ ":" (str.++ "/" (str.++ "/" (str.++ "f" (str.++ "." (str.++ "K" ""))))))))))))
;witness2: "ftp://PNzZ-s-Q.D.y.;f\u00AA"
(define-fun Witness2 () String (str.++ "f" (str.++ "t" (str.++ "p" (str.++ ":" (str.++ "/" (str.++ "/" (str.++ "P" (str.++ "N" (str.++ "z" (str.++ "Z" (str.++ "-" (str.++ "s" (str.++ "-" (str.++ "Q" (str.++ "." (str.++ "D" (str.++ "." (str.++ "y" (str.++ "." (str.++ ";" (str.++ "f" (str.++ "\u{aa}" "")))))))))))))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.union (str.to_re (str.++ "h" (str.++ "t" ""))) (re.range "f" "f"))(re.++ (str.to_re (str.++ "t" (str.++ "p" "")))(re.++ (re.opt (re.range "s" "s"))(re.++ (str.to_re (str.++ ":" (str.++ "/" (str.++ "/" ""))))(re.++ (re.union (re.++ (re.+ (re.union (re.range "-" ".")(re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_") (re.range "a" "z")))))) (re.+ (re.++ (re.range "." ".") (re.+ (re.union (re.range "-" ".")(re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_") (re.range "a" "z"))))))))) (str.to_re (str.++ "l" (str.++ "o" (str.++ "c" (str.++ "a" (str.++ "l" (str.++ "h" (str.++ "o" (str.++ "s" (str.++ "t" "")))))))))))(re.++ (re.opt (re.range "/" "/"))(re.++ (re.opt (re.* (re.union (re.range "#" "'")(re.union (re.range "+" "9")(re.union (re.range ";" ";")(re.union (re.range "?" "?")(re.union (re.range "A" "Z")(re.union (re.range "\u{5c}" "\u{5c}")(re.union (re.range "_" "_") (re.range "a" "z"))))))))))(re.++ (re.* (re.union (re.range "%" "'")(re.union (re.range "+" ";")(re.union (re.range "=" "=")(re.union (re.range "?" "?")(re.union (re.range "A" "Z")(re.union (re.range "\u{5c}" "\u{5c}")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "|" "|")(re.union (re.range "~" "~")(re.union (re.range "\u{aa}" "\u{aa}")(re.union (re.range "\u{b5}" "\u{b5}")(re.union (re.range "\u{ba}" "\u{ba}")(re.union (re.range "\u{c0}" "\u{d6}")(re.union (re.range "\u{d8}" "\u{f6}") (re.range "\u{f8}" "\u{ff}"))))))))))))))))) (str.to_re ""))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
